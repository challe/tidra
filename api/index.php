<?php
require("vendor/autoload.php");
require 'rb.php';
require 'config.php';

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \Firebase\JWT\JWT;

// Cors
if (isset($_SERVER['HTTP_ORIGIN'])) {
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header('Access-Control-Allow-Credentials: true');
    header('Access-Control-Allow-Headers: Content-Type');
    header('Access-Control-Allow-Methods: GET, POST, PUT, OPTIONS');
    header('Access-Control-Max-Age: 86400');    // cache for 1 day
}

// Database
R::setup($db, $username, $password);
R::freeze(true);

$root_url = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";

$configuration = [
    'settings' => [
        'displayErrorDetails' => true,
    ],
];
$c = new \Slim\Container($configuration);
$app = new \Slim\App($c);

// TESTAR MIDDLEWARE
class ExampleMiddleware
{
    /**
     * Example middleware invokable class
     *
     * @param  \Psr\Http\Message\ServerRequestInterface $request  PSR7 request
     * @param  \Psr\Http\Message\ResponseInterface      $response PSR7 response
     * @param  callable                                 $next     Next middleware
     *
     * @return \Psr\Http\Message\ResponseInterface
     */
    public function __invoke($request, $response, $next)
    {
        /*

        $requestHeaders = apache_request_headers();
        $jwt = (array_key_exists('Authorization', $requestHeaders) ? $requestHeaders['Authorization'] : null;

        print_r($jwt);

        $decoded = JWT::decode($jwt, $jwtKey, array('HS256'));

        print_r($decoded);

        $path = $request->getUri()->getPath();

        $response->getBody()->write($path);
        $response = $next($request, $response);
        $response->getBody()->write('AFTER');

        return $response;*/
    }
}
//$app->add( new ExampleMiddleware() );


$app->get('/', function (Request $request, Response $response) {
	echo "hello world";
});

$app->get('/users/{id}', function (Request $request, Response $response) {
    $id = $request->getAttribute('id');
    $user = R::find('user', 'id = ?', [$id]);
    $user = R::exportAll($user);

    return $response->withStatus(200)
        ->withHeader('Content-Type', 'application/json')
        ->write(json_encode($user, JSON_UNESCAPED_SLASHES));
});
$app->get('/users', function (Request $request, Response $response) {
	$users = R::find('user');
    $users = R::exportAll($users);

    return $response->withStatus(200)
        ->withHeader('Content-Type', 'application/json')
        ->write(json_encode($users));
});
$app->post('/users', function (Request $request, Response $response) use ($root_url) {
    $json = $request->getBody();
    $input = json_decode($json, true); // parse the JSON into an assoc. array

    $user = R::dispense('user');
    $user->name = $input["name"];
    $id = R::store($user);

    $link = $root_url . '/' . $id;

    return $response->withStatus(201)
        ->withHeader('Content-Type', 'application/json')
        ->withHeader('Location', $link)
        ->write(json_encode(['id' => $id, 'link' => $link], JSON_UNESCAPED_SLASHES));
});
$app->put('/users/{id}', function (Request $request, Response $response) use ($root_url) {
    $json = $request->getBody();
    $input = json_decode($json, true);

    $id = $input["id"];

    $customer = R::load('user', $id);
    $customer->name = $input["name"];
    $id = R::store($customer);

    $link = $root_url;

    return $response->withStatus(200)
        ->withHeader('Content-Type', 'application/json')
        ->write(json_encode(['id' => $id, 'link' => $link], JSON_UNESCAPED_SLASHES));
});

/*
    Customers
*/
$app->get('/customers/{id}', function (Request $request, Response $response) {
    $id = $request->getAttribute('id');
    $customer = R::find('customer', 'id = ?', [$id]);
    $customer = R::exportAll($customer);

    return $response->withStatus(200)
        ->withHeader('Content-Type', 'application/json')
        ->write(json_encode($customer, JSON_UNESCAPED_SLASHES));
});
$app->get('/customers', function (Request $request, Response $response) {
	$customers = R::find('customer');
    $customers = R::exportAll($customers);

    return $response->withStatus(200)
        ->withHeader('Content-Type', 'application/json')
        ->write(json_encode($customers));
});
$app->post('/customers', function (Request $request, Response $response) use ($root_url) {
    $json = $request->getBody();
    $input = json_decode($json, true); // parse the JSON into an assoc. array

    $customer = R::dispense('customer');
    $customer->name = $input["name"];
    $id = R::store($customer);

    $link = $root_url . '/' . $id;

    return $response->withStatus(201)
        ->withHeader('Content-Type', 'application/json')
        ->withHeader('Location', $link)
        ->write(json_encode(['id' => $id, 'link' => $link], JSON_UNESCAPED_SLASHES));
});
$app->put('/customers/{id}', function (Request $request, Response $response) use ($root_url) {
    $json = $request->getBody();
    $input = json_decode($json, true);

    $id = $input["id"];

    $customer = R::load('customer', $id);
    $customer->name = $input["name"];
    $id = R::store($customer);

    $link = $root_url;

    return $response->withStatus(200)
        ->withHeader('Content-Type', 'application/json')
        ->write(json_encode(['id' => $id, 'link' => $link], JSON_UNESCAPED_SLASHES));
});

/*
    Timelog
*/
$app->get('/timelogs/{id}', function (Request $request, Response $response) {
    $id = $request->getAttribute('id');
    $timelog = R::find('timelog', 'id = ?', [$id]);
    $timelog = R::exportAll($timelog);

    return $response->withStatus(200)
        ->withHeader('Content-Type', 'application/json')
        ->write(json_encode($timelog, JSON_UNESCAPED_SLASHES));
});
$app->get('/timelogs', function (Request $request, Response $response) {
    $sql = "SELECT timelog.*, user.name as user_name, customer.name as customer_name ";
    $sql .= "FROM timelog ";
    $sql .= "INNER JOIN user on user.id = user_id ";
    $sql .= "INNER JOIN customer on customer.id = customer_id";

    $timelogs = R::getAll($sql);

    return $response->withStatus(200)
        ->withHeader('Content-Type', 'application/json')
        ->write(json_encode($timelogs));
});
$app->post('/timelogs', function (Request $request, Response $response) use ($root_url) {
    $json = $request->getBody();
    $input = json_decode($json, true); // parse the JSON into an assoc. array

    $timelog = R::dispense('timelog');
    $timelog->date = $input["date"];
    $timelog->user_id = $input["user_id"];
    $timelog->customer_id = $input["customer_id"];
    $timelog->hours = $input["hours"];
    $timelog->minutes = $input["minutes"];
    $timelog->kilometers = $input["kilometers"];
    $timelog->text = $input["text"];

    $id = R::store($timelog);

    $link = $root_url . '/' . $id;

    return $response->withStatus(201)
        ->withHeader('Content-Type', 'application/json')
        ->withHeader('Location', $link)
        ->write(json_encode(['id' => $id, 'link' => $link], JSON_UNESCAPED_SLASHES));
});

/*
    Invoice details
*/
$app->get('/invoicedetails/{customer_id}/{start}/{stop}', function (Request $request, Response $response) {
    $customer_id = $request->getAttribute('customer_id');
    $start = $request->getAttribute('start');
    $stop = $request->getAttribute('stop');

    $sql = "select customer_id, customer_name, sum(hours) as hours_total, ifnull(sum(kilometers),0) as kilometers_total, ";
    $sql .= "(select ifnull(sum(hours),0) from timelog where customer_id = " . $customer_id . " and date between '" . $start . "' and '" . $stop . "') as hours_period, ";
    $sql .= "(select ifnull(sum(kilometers), 0) from timelog where customer_id = " . $customer_id . " and date between '" . $start . "' and '" . $stop . "') as kilometers_period, ";
    $sql .= "'" . $start . "' as from_date, '" . $stop . "' as to_date ";
    $sql .= "from ";
    $sql .= "( ";
    $sql .= "select customer.id as customer_id, customer.name as customer_name, date, hours, kilometers from timelog ";
    $sql .= "inner join customer on customer.id = timelog.customer_id ";
    $sql .= "where customer_id = " . $customer_id . " ";
    $sql .= ") total";

    $invoice_details = R::getAll($sql);

    // Users on project
    $sql = "select distinct user.id as id, user.name, sum(hours) as hours_worked ";
    $sql .= "from timelog ";
    $sql .= "inner join user on user.id = timelog.user_id ";
    $sql .= "where customer_id = " . $customer_id;

    $users = R::getAll($sql);

    $invoice_details["users"] = $users;

    return $response->withStatus(200)
        ->withHeader('Content-Type', 'application/json')
        ->write(json_encode($invoice_details, JSON_UNESCAPED_SLASHES));
});

/*
    Salary details
*/
$app->get('/salarydetails/{user_id}/{start}/{stop}', function (Request $request, Response $response) {
    $user_id = $request->getAttribute('user_id');
    $start = $request->getAttribute('start');
    $stop = $request->getAttribute('stop');

    R::exec("SET lc_time_names = 'sv_SE';");

    $sql = "select user.id as user_id, user.name as user_name, ifnull(sum(hours), 0) as hours, ifnull(sum(kilometers), 0) as kilometers,  ";
    $sql .= "(select ifnull(sum(datediff(`to`, `from`) + 1), 0) from absence where user_id = " . $user_id . " and absence_type_id = 1 and (`from` <= '" . $stop . "') and (`to` >= '" . $start . "')) as sjuk, ";
    $sql .= "(select ifnull(sum(datediff(`to`, `from`) + 1), 0) from absence where user_id = " . $user_id . " and absence_type_id = 2 and (`from` <= '" . $stop . "') and (`to` >= '" . $start . "')) as vab, ";
    $sql .= "(select ifnull(sum(datediff(`to`, `from`) + 1), 0) from absence where user_id = " . $user_id . " and absence_type_id = 3 and (`from` <= '" . $stop . "') and (`to` >= '" . $start . "')) as sem, ";
    $sql .= "'" . $start . "' as from_date, '" . $stop . "' as to_date ";
    $sql .= "from timelog ";
    $sql .= "inner join user on user.id = timelog.user_id ";
    $sql .= "where user_id = " . $user_id . " and date between '" . $start . "' and '" . $stop . "'";

    $salary_details = R::getAll($sql);

    $salary_details["days"] = R::getAll("call getDatesForUser(" . $user_id . ", '" . $start . "', '". $stop . "')");

    return $response->withStatus(200)
        ->withHeader('Content-Type', 'application/json')
        ->write(json_encode($salary_details, JSON_UNESCAPED_SLASHES));
});

/*
    Absence
*/
$app->post('/absence', function (Request $request, Response $response) use ($root_url) {
    $json = $request->getBody();
    $input = json_decode($json, true); // parse the JSON into an assoc. array

    $absence = R::dispense('absence');
    $absence->absence_type_id = $input["absence_type_id"];
    $absence->user_id = $input["user_id"];
    $absence->from = $input["from_date"];
    $absence->to = $input["to_date"];

    $id = R::store($absence);

    $link = $root_url . '/' . $id;

    return $response->withStatus(201)
        ->withHeader('Content-Type', 'application/json')
        ->withHeader('Location', $link)
        ->write(json_encode(['id' => $id, 'link' => $link], JSON_UNESCAPED_SLASHES));
});

/*
    Absence types
*/
$app->get('/absencetypes', function (Request $request, Response $response) {
	$absencetypes = R::find('absence_type');
    $absencetypes = R::exportAll($absencetypes);

    return $response->withStatus(200)
        ->withHeader('Content-Type', 'application/json')
        ->write(json_encode($absencetypes));
});

/*
    Auth
*/
$app->post('/auth', function (Request $request, Response $response) use ($root_url, $jwtKey) {
    $json = $request->getBody();
    $input = json_decode($json, true);

    $username = $input["username"];
    $password = $input["password"];

    $sql = "SELECT * FROM user where username = '" . $username . "' AND password = '" . $password . "' ";

    $user = R::getAll($sql);

    if (count($user) == 1) {
        $token = array(
            "name" => $user[0]["name"]
        );

        $jwt = JWT::encode($token, $jwtKey);

        $obj = ["error" => false, 'token' => $jwt];
    }
    else {
        $obj = ['error' => true];
    }

    return $response->withStatus(201)
        ->withHeader('Content-Type', 'application/json')
        ->write(json_encode($obj, JSON_UNESCAPED_SLASHES));
});

$app->get('/auth/validate/{token}', function (Request $request, Response $response) use ($root_url, $jwtKey) {
    $token = $request->getAttribute('token');

    //$requestHeaders = apache_request_headers();
    //$jwt = (array_key_exists('Authorization', $requestHeaders)) ? $requestHeaders['Authorization'] : null;

    try{
        $decoded = JWT::decode($token, $jwtKey, array('HS256'));
        $obj = ['error' => false, 'valid' => true];

    }catch(Exception $e){
        $obj = ['error' => true, 'message' => "Invalid token"];
    }

    return $response->withStatus(201)
        ->withHeader('Content-Type', 'application/json')
        ->write(json_encode($obj, JSON_UNESCAPED_SLASHES));
});





$app->run();
?>