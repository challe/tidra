import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'package:tidra/services/user.dart';

@Directive(
  selector: 'auth-router-outlet'
)
class LoggedInRouterOutlet extends RouterOutlet  {
  var publicRoutes;
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
    this.publicRoutes = [
      '', 'timelog', 'absence', 'login'
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
    // The url is the full url with parameters, for example login/salarydetails
    // We are only interested in checking the page, not the parameters
    String page = (url.indexOf("/") != -1) ? url.substring(0, url.indexOf("/")) : url;

    bool isLoggedIn = await this._userService.isLoggedIn();

    return (this.publicRoutes.indexOf(page) != -1 || isLoggedIn);
  }
}