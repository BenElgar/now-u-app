import 'package:flutter/material.dart';
import 'package:app/assets/components/pageTitle.dart';
import 'package:app/models/Reward.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double ICON_PADDING = 40;
const double ITEM_HORIZONTAL = 30;
const double ITEM_VERTICAL = 30;

var _rewards = <Reward>[
  Reward(id: 1, title: "Shower Rail", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", completed:false ),
  Reward(id: 1, title: "One way tickets to Mozambique", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", completed:false ),
  Reward(id: 1, title: "James Elgar", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", completed:false),
  Reward(id: 1, title: "22% of VegWare", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", completed:false ),
  Reward(id: 1, title: "£5 amazon voucher", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", completed:false ),
  Reward(id: 1, title: "A car", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", completed:false ),
  Reward(id: 1, title: "24% of VegWare", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", completed:false ),
];

class RewardsPage extends StatelessWidget {
  GestureTapCallback _goBack;

  RewardsPage(goBack) {
    _goBack = goBack;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          PageTitle("Rewards", hasBackButton: true, onClickBackButton: _goBack,),
          Text("You have completed x campaigns",
            style: Theme.of(context).primaryTextTheme.body1),
          Text("Thankyou",
            style: Theme.of(context).primaryTextTheme.body1),
          Expanded(
            child:
            ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: _rewards.length,
              itemBuilder: (context, index) =>
                  GestureDetector(
                    // TODO Offer more info page
                    onTap: () {},
                    child: RewardTile(_rewards[index]),
                  ),
            ),
          ),
          DarkButton("See Highlights",
            onPressed: (){})
        ]
    );
  }
}

class RewardTile extends StatelessWidget {
  Reward _reward;

  RewardTile(reward) {
    _reward = reward;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
          padding: EdgeInsets.fromLTRB(ITEM_HORIZONTAL, ITEM_VERTICAL, ITEM_HORIZONTAL, ITEM_VERTICAL),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: ICON_PADDING),
                  child: Icon(FontAwesomeIcons.ribbon, size: 50,)
              ),
              Text(_reward.getTitle(), style: Theme.of(context).primaryTextTheme.body1),
            ],
          ),
        )
    );
  }
}