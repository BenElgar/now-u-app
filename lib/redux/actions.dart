import 'package:app/models/User.dart';
import 'package:app/models/Action.dart';

class SelectCampaignsAction {
  final User user;

  SelectCampaignsAction(this.user);
}

class CompleteAction {
  final CampaignAction action;

  CompleteAction(this.action);
}

//class GetCampaingsAction {}

//class LoadedCampaignsAction {
//  final List<Campaign> campaigns;
//
//  LoadedCampaignsAction(this.campaigns);
//}

class GetUserDataAction {}

class LoadedUserDataAction {
  final User user;

  LoadedUserDataAction(this.user);
}