[<img src='assets/For-post.png' alt='banner' width= '99.9%'>]()

<div align="center">
     <a href="https://discord.gg/fAaQR8cWrt">
          <img src='https://github.com/trusted-point/celestia-tools/assets/20209819/14e7911e-b6e7-4404-8a37-58866eb1ced3' alt='Join Monitoring'  width='100%'>
     </a>
</div>

---

</br>
<div align="center">
     <a href="#">
          <img src='https://github.com/trusted-point/celestia-tools/assets/20209819/15c56049-2e23-425b-aabf-f22291ec34cf' alt='Key Features'  width='70%'>
     </a>
</div>
</br>

- Our bot serves as a vital tool for Celestia network participants, offering comprehensive insights into the network's dynamics, validators, governance proceedings, upcoming upgrades, emergency alerts, and key metrics.

- Alert Services: For validators and stakeholders, the bot provides subscription services for timely alerts. Users receive notifications about critical events such as block skipping, validator exclusion from an active set, commission adjustments, and more.

- Real-Time Block Streaming: The bot supports real-time streaming of newly produced blocks to a particular channel, enabling users to stay updated on network activities instantly.

- Validator Metrics: Users can easily find reliable validators to stake tokens through the bot's detailed metrics. These metrics include governance participation, total number of slashes, number of delegators, uptime, voting power, and more.

- Our bot can also perform an on-chain RPC and persistent peers scanning.

</br>
<div align="center">
     <a href="#">
          <img src='https://github.com/trusted-point/celestia-tools/assets/20209819/717ec8c7-624d-41e5-b43b-413ce3e57273' alt='Commands'  width='70%'>
     </a>
</div>
</br>

<a href="#">
          <img src='https://github.com/trusted-point/celestia-tools/assets/20209819/8cccb0e0-f7b9-4055-a79b-4d651f04dc04' alt='Services'  width='25%'>
</a>

- `!rpc`: Onchain RPC scanning
- `!peers`: Onchain peers scanning

<a href="#">
          <img src='https://github.com/trusted-point/celestia-tools/assets/20209819/7a6677d8-23e5-4bed-9c07-d7f9c3623d51' alt='Validators'  width='25%'>
</a>

- `!val <valoper>`: Key validator metrics + real-time blocks signing
- `!vals`: Uptime + VP %
- `!vals_stake`: Number of delegators + stake + 24-h stake changes
- `!vals_slash`: Total number of slashes of each validator + commission %
- `!cons`: Consensus info (Use during upgrades)
- `!vals_all`: All validators including bonded, unbonded, unbonding
- `!vals_live`: Real-Time validators signatures
- `!self`: Check all validators that you are subscribing without providing a valoper

<a href="#">
          <img src='https://github.com/trusted-point/celestia-tools/assets/20209819/7a8c73fe-26ea-4d18-a691-d3e50f5e627c' alt='Bridge'  width='25%'>
</a>

- `!sub_bridge`: Subscribe bridge alerts
- `!subs_bridge`: Check you current bridge subscription/s
- `!unsub_bridge`: Unubscribe all bridge alerts
- `!self_bridge`: To quickly check bridges you are subscribing

<a href="#">
          <img src='https://github.com/trusted-point/celestia-tools/assets/20209819/0cb7ca15-a11f-4482-b250-1ae87a87cf20' alt='Chain'  width='25%'>
</a>

- `!chain`: Useful chain metrics
- `!params`: Network parameters + binary/tendermint/SDK versions
- `!upgrade`: Current upgrade plan. The bot automatically announces new upgrades. You can subscribe to receive a reminder 100 blocks before the upgrade height. You can manually check the current upgrade plan and subscribe to reminders.

<a href="#">
          <img src='https://github.com/trusted-point/celestia-tools/assets/20209819/b158c078-25d7-4855-ba6c-0ef90b1ea1e9' alt='Governance'  width='25%'>
</a>

- The bot automatically announces new governance proposals. You can view the current voting status & validator votes as well as subscribe to receive a ping once a new proposal is out (All by clicking buttons under the bot's announcement). You can also check details of the given proposal manually.
- `!props`: All proposals & ids of the active ones
- `!prop <id>`: Proposal info
- `!prop_res <id>`: Proposal expected result
- `!prop_votes <id>`: Active validators votes

<a href="#">
          <img src='https://github.com/trusted-point/celestia-tools/assets/20209819/b4068adf-97ab-4cc2-b46a-cf7b87a771b9' alt='Alerts'  width='25%'>
</a>

- `!subs`: Check your validators alerts subscriptions
- `!sub <valoper>`: Subscribe validator alerts
- `!unsub <valoper>`: Unsubscribe validator alerts
- `!unsub_all`: Unsubscribe all validators
- `!self`: Check all validators that you are subscribing without providing a valoper
- Manual subscription to governance announcements
- `!sub_gov`: Subscribe governance announcements
- `!unsub_gov`: Unsubscribe governance announcements

<a href="#">
          <img src='https://github.com/trusted-point/celestia-tools/assets/20209819/7f013ff2-e5a3-4a8d-bbc9-a6d1c6c5ee75' alt='Other'  width='25%'>
</a>

- `!feedback`: Leave us feedback / Report a bug
- `!help`: All available commands with description

</br>
<div align="center">
     <a href="#">
          <img src='https://github.com/trusted-point/celestia-tools/assets/20209819/b88ce19f-7147-46ee-a71e-edb9e5588f85' alt='Validator Alert Tresholds'  width='70%'>
     </a>
</div>
</br>

- Level one:   <95% (mocha: 90%)
- Level two:   <87% (mocha: 75%)
- Level three: <79% (mocha: 50%)
- Recovering
- Recovered
- Commission change
- Moniker change
- Dropping out of the active set
- Joining the active set
  
</br>
<div align="center">
     <a href="#">
          <img src='https://github.com/trusted-point/celestia-tools/assets/20209819/c2d9b1e9-0908-4379-b376-ec4cadf75922' alt='Bridge Alert Tresholds'  width='70%'>
     </a>
</div>
</br>

- Out of sync: when bridge's local height is 500 headers below the glogal ones 
- Stuck: when bridge's local height is stuck for > 10 minutes
- Down: when bridge's RPC port is unreachable for > 10 minutes
