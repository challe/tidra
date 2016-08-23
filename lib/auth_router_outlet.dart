import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'package:tidra/services/user.dart';

@Directive(
  selector: 'auth-router-outlet'
)
class LoggedInRouterOutlet extends RouterOutlet  {
  var publicRoutes;
  var employeeRoutes;
  Router _parentRouter;
  UserService _userService;

  LoggedInRouterOutlet(
    ViewContainerRef viewContainerRef,
    DynamicComponentLoader loader,
    Router parentRouter,
    @Attribute('name') String nameAttr,
    UserService userService
  ) : super(viewContainerRef, loader, parentRouter, nameAttr) {
    this._parentRouter = parentRouter;
    this._userService = userService;
    this.publicRoutes = ['', 'home', 'login', 'logout'];
    this.employeeRoutes = [
      '', 'timelog', 'absence', 'mytimelogdetails'
    ];
  }

  activate(ComponentInstruction instruction) async {
    if (await this._canActivate(instruction.urlPath)) {
      return super.activate(instruction);
    }

    // The path itself can not be login, or else we would be looping forever
    if(!instruction.urlPath.contains("login")) {
      this._parentRouter.navigate(['Login', {'page': instruction.urlPath}]);
    }
  }

  _canActivate(String url) async {
    bool canActivate = false;
    // The url is the full url with parameters, for example login/salarydetails
    // We are only interested in checking the page, not the parameters
    String page = (url.indexOf("/") != -1) ? url.substring(0, url.indexOf("/")) : url;

    Map<String, dynamic> info = new Map<String, String>();
    info = await this._userService.getUserInformation();

    // If the page is public, it can activate
    if(this.publicRoutes.indexOf(page) != -1) {
      canActivate = true;
    }
    // If the page is only accessible for employees and you are logged in
    else if(this.employeeRoutes.indexOf(page) != -1 && info["is_logged_in"])
    {
      canActivate = true;
    }
    // If the user is logged in and admin, the route does not matter
    else if(info["is_logged_in"] && info["is_admin"]) {
      canActivate = true;
    }

    return canActivate;
  }
}