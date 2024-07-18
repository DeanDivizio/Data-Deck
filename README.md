# Data Deck
### *Better At-A-Glance Data Visualization for Apple HealthKit Data*
<br />

## Summary
I was really dissatified with the way data is presented in Apple's Health and Fitness apps. In health, all data points take up a fullwidth module, which seems excessive. You have to go to the Fitness app to view total calories (or add the resting energy and active energy stats in your head.... lame). There's no good at-a-glance section. The idea would be one dashboard where you can view all the metrics you're interested in in a way that's functional and aesthetically pleasing.

## Goals
I have no desire to push this to the app store, but would like it to be in a state where anyone could clone this repo and sign/deploy for themselves. After adding support for all (subjectively) relevant health metrics, it might be fun to add other metrics as well. Not sure what those would be (battery? free storage?) but one app to give a dashboard for any metrics you'd like to track would be nifty.

## To-Do
- [ ] Overall
  - [ ] Make data fetching more extensible
  - [ ] Add support for more metrics
  - [ ] Implement a loading screen
  - [ ] Make an icon
- [ ] Home Page
  - [ ] Refine Design
    - [x] Cards are good
    - [ ] Text spacing is weird
    - [ ] Not sold on Background
      - [ ] Consider different colors
      - [ ] Maybe add texture
      - [ ] Maybe add animation
  - [ ] Click on a card to view trend data if applicable
    - [ ] Maybe outline cards that are clickable?
- [ ] Settings Page
  - [ ] Data point selection
  - [ ] Light/Dark Toggle (?)
  - [ ] Force data refetching
