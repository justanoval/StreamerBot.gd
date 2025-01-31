extends Node

signal follow(payload: Dictionary)
signal cheer(payload: Dictionary)
signal sub(payload: Dictionary)
signal re_sub(payload: Dictionary)
signal gift_sub(payload: Dictionary)
signal gift_bomb(payload: Dictionary)
signal raid(payload: Dictionary)
signal hype_train_start(payload: Dictionary)
signal hype_train_update(payload: Dictionary)
signal hype_train_level_up(payload: Dictionary)
signal hype_train_end(payload: Dictionary)
signal reward_redemption(payload: Dictionary)
signal reward_created(payload: Dictionary)
signal reward_updated(payload: Dictionary)
signal reward_deleted(payload: Dictionary)
signal community_goal_contribution(payload: Dictionary)
signal community_goal_ended(payload: Dictionary)
signal stream_update(payload: Dictionary)
signal whisper(payload: Dictionary)
signal first_word(payload: Dictionary)
signal sub_counter_rollover(payload: Dictionary)
signal broadcast_update(payload: Dictionary)
signal stream_update_game_on_connect(payload: Dictionary)
signal present_viewers(payload: Dictionary)
signal poll_created(payload: Dictionary)
signal poll_updated(payload: Dictionary)
signal poll_completed(payload: Dictionary)
signal prediction_created(payload: Dictionary)
signal prediction_updated(payload: Dictionary)
signal prediction_completed(payload: Dictionary)
signal prediction_canceled(payload: Dictionary)
signal prediction_locked(payload: Dictionary)
signal chat_message(payload: Dictionary)
signal chat_message_deleted(payload: Dictionary)
signal user_timed_out(payload: Dictionary)
signal user_banned(payload: Dictionary)
signal announcement(payload: Dictionary)
signal ad_run(payload: Dictionary)
signal bot_whisper(payload: Dictionary)
signal charity_donation(payload: Dictionary)
signal charity_completed(payload: Dictionary)
signal coin_cheer(payload: Dictionary)
signal shoutout_created(payload: Dictionary)
signal user_untimed_out(payload: Dictionary)
signal charity_started(payload: Dictionary)
signal charity_progress(payload: Dictionary)
signal goal_begin(payload: Dictionary)
signal goal_progress(payload: Dictionary)
signal goal_end(payload: Dictionary)
signal shield_mode_begin(payload: Dictionary)
signal shield_mode_end(payload: Dictionary)
signal ad_mid_roll(payload: Dictionary)
signal stream_online(payload: Dictionary)
signal stream_offline(payload: Dictionary)
signal shoutout_received(payload: Dictionary)
signal chat_cleared(payload: Dictionary)
signal raid_start(payload: Dictionary)
signal raid_send(payload: Dictionary)
signal raid_cancelled(payload: Dictionary)
signal poll_terminated(payload: Dictionary)
signal pyramid_success(payload: Dictionary)
signal pyramid_broken(payload: Dictionary)
signal viewer_count_update(payload: Dictionary)
signal guest_star_session_begin(payload: Dictionary)
signal guest_star_session_end(payload: Dictionary)
signal guest_star_guest_update(payload: Dictionary)
signal guest_star_slot_update(payload: Dictionary)
signal guest_star_settings_update(payload: Dictionary)
signal hype_chat(payload: Dictionary)
signal reward_redemption_updated(payload: Dictionary)
signal hype_chat_level(payload: Dictionary)
signal broadcaster_authenticated(payload: Dictionary)
signal broadcaster_chat_connected(payload: Dictionary)
signal broadcaster_chat_disconnected(payload: Dictionary)
signal broadcaster_pub_sub_connected(payload: Dictionary)
signal broadcaster_pub_sub_disconnected(payload: Dictionary)
signal broadcaster_event_sub_connected(payload: Dictionary)
signal broadcaster_event_sub_disconnected(payload: Dictionary)
signal seven_tv_emote_added(payload: Dictionary)
signal seven_tv_emote_removed(payload: Dictionary)
signal better_ttv_emote_added(payload: Dictionary)
signal better_ttv_emote_removed(payload: Dictionary)
signal bot_event_sub_connected(payload: Dictionary)
signal bot_event_sub_disconnected(payload: Dictionary)
signal upcoming_ad(payload: Dictionary)
signal moderator_added(payload: Dictionary)
signal moderator_removed(payload: Dictionary)
signal vip_added(payload: Dictionary)
signal vip_removed(payload: Dictionary)
signal user_unbanned(payload: Dictionary)
signal unban_request_approved(payload: Dictionary)
signal unban_request_denied(payload: Dictionary)
signal automatic_reward_redemption(payload: Dictionary)
signal unban_request_created(payload: Dictionary)
signal chat_emote_mode_on(payload: Dictionary)
signal chat_emote_mode_off(payload: Dictionary)
signal chat_follower_mode_on(payload: Dictionary)
signal chat_follower_mode_off(payload: Dictionary)
signal chat_follower_mode_changed(payload: Dictionary)
signal chat_slow_mode_on(payload: Dictionary)
signal chat_slow_mode_off(payload: Dictionary)
signal chat_slow_mode_changed(payload: Dictionary)
signal chat_subscriber_mode_on(payload: Dictionary)
signal chat_subscriber_mode_off(payload: Dictionary)
signal chat_unique_mode_on(payload: Dictionary)
signal chat_unique_mode_off(payload: Dictionary)
signal auto_mod_message_held(payload: Dictionary)
signal auto_mod_message_update(payload: Dictionary)
signal blocked_terms_added(payload: Dictionary)
signal blocked_terms_deleted(payload: Dictionary)
signal warned_user(payload: Dictionary)
signal suspicious_user_update(payload: Dictionary)
signal permitted_terms_added(payload: Dictionary)
signal permitted_terms_deleted(payload: Dictionary)
signal warning_acknowledged(payload: Dictionary)
signal watch_streak(payload: Dictionary)
signal poll_archived(payload: Dictionary)
signal shared_chat_session_begin(payload: Dictionary)
signal shared_chat_session_update(payload: Dictionary)
signal shared_chat_session_end(payload: Dictionary)
signal prime_paid_upgrade(payload: Dictionary)
signal pay_it_forward(payload: Dictionary)
signal gift_paid_upgrade(payload: Dictionary)
signal bits_badge_tier(payload: Dictionary)
signal shared_chat_announcement(payload: Dictionary)
signal shared_chat_raid(payload: Dictionary)
signal shared_chat_prime_paid_upgrade(payload: Dictionary)
signal shared_chat_gift_paid_upgrade(payload: Dictionary)
signal shared_chat_pay_it_forward(payload: Dictionary)
signal shared_chat_sub(payload: Dictionary)
signal shared_chat_resub(payload: Dictionary)
signal shared_chat_sub_gift(payload: Dictionary)
signal shared_chat_community_sub_gift(payload: Dictionary)
signal shared_chat_user_banned(payload: Dictionary)
signal shared_chat_user_unbanned(payload: Dictionary)
signal shared_chat_user_timedout(payload: Dictionary)
signal shared_chat_user_untimedout(payload: Dictionary)
signal shared_chat_message_deleted(payload: Dictionary)

func _ready() -> void:
	StreamerBot.connected.connect(_on_streamer_bot_connected)

func _on_streamer_bot_connected() -> void:
	print("Twitch connected!")
	StreamerBot.subscribe({"twitch": ["Follow"]}, func(payload): follow.emit(payload))
	StreamerBot.subscribe({"twitch": ["Cheer"]}, func(payload): cheer.emit(payload))
	StreamerBot.subscribe({"twitch": ["Sub"]}, func(payload): sub.emit(payload))
	StreamerBot.subscribe({"twitch": ["ReSub"]}, func(payload): re_sub.emit(payload))
	StreamerBot.subscribe({"twitch": ["GiftSub"]}, func(payload): gift_sub.emit(payload))
	StreamerBot.subscribe({"twitch": ["GiftBomb"]}, func(payload): gift_bomb.emit(payload))
	StreamerBot.subscribe({"twitch": ["Raid"]}, func(payload): raid.emit(payload))
	StreamerBot.subscribe({"twitch": ["HypeTrainStart"]}, func(payload): hype_train_start.emit(payload))
	StreamerBot.subscribe({"twitch": ["HypeTrainUpdate"]}, func(payload): hype_train_update.emit(payload))
	StreamerBot.subscribe({"twitch": ["HypeTrainLevelUp"]}, func(payload): hype_train_level_up.emit(payload))
	StreamerBot.subscribe({"twitch": ["HypeTrainEnd"]}, func(payload): hype_train_end.emit(payload))
	StreamerBot.subscribe({"twitch": ["RewardRedemption"]}, func(payload): reward_redemption.emit(payload))
	StreamerBot.subscribe({"twitch": ["RewardCreated"]}, func(payload): reward_created.emit(payload))
	StreamerBot.subscribe({"twitch": ["RewardUpdated"]}, func(payload): reward_updated.emit(payload))
	StreamerBot.subscribe({"twitch": ["RewardDeleted"]}, func(payload): reward_deleted.emit(payload))
	StreamerBot.subscribe({"twitch": ["CommunityGoalContribution"]}, func(payload): community_goal_contribution.emit(payload))
	StreamerBot.subscribe({"twitch": ["CommunityGoalEnded"]}, func(payload): community_goal_ended.emit(payload))
	StreamerBot.subscribe({"twitch": ["StreamUpdate"]}, func(payload): stream_update.emit(payload))
	StreamerBot.subscribe({"twitch": ["Whisper"]}, func(payload): whisper.emit(payload))
	StreamerBot.subscribe({"twitch": ["FirstWord"]}, func(payload): first_word.emit(payload))
	StreamerBot.subscribe({"twitch": ["SubCounterRollover"]}, func(payload): sub_counter_rollover.emit(payload))
	StreamerBot.subscribe({"twitch": ["BroadcastUpdate"]}, func(payload): broadcast_update.emit(payload))
	StreamerBot.subscribe({"twitch": ["StreamUpdateGameOnConnect"]}, func(payload): stream_update_game_on_connect.emit(payload))
	StreamerBot.subscribe({"twitch": ["PresentViewers"]}, func(payload): present_viewers.emit(payload))
	StreamerBot.subscribe({"twitch": ["PollCreated"]}, func(payload): poll_created.emit(payload))
	StreamerBot.subscribe({"twitch": ["PollUpdated"]}, func(payload): poll_updated.emit(payload))
	StreamerBot.subscribe({"twitch": ["PollCompleted"]}, func(payload): poll_completed.emit(payload))
	StreamerBot.subscribe({"twitch": ["PredictionCreated"]}, func(payload): prediction_created.emit(payload))
	StreamerBot.subscribe({"twitch": ["PredictionUpdated"]}, func(payload): prediction_updated.emit(payload))
	StreamerBot.subscribe({"twitch": ["PredictionCompleted"]}, func(payload): prediction_completed.emit(payload))
	StreamerBot.subscribe({"twitch": ["PredictionCanceled"]}, func(payload): prediction_canceled.emit(payload))
	StreamerBot.subscribe({"twitch": ["PredictionLocked"]}, func(payload): prediction_locked.emit(payload))
	StreamerBot.subscribe({"twitch": ["ChatMessage"]}, func(payload): chat_message.emit(payload))
	StreamerBot.subscribe({"twitch": ["ChatMessageDeleted"]}, func(payload): chat_message_deleted.emit(payload))
	StreamerBot.subscribe({"twitch": ["UserTimedOut"]}, func(payload): user_timed_out.emit(payload))
	StreamerBot.subscribe({"twitch": ["UserBanned"]}, func(payload): user_banned.emit(payload))
	StreamerBot.subscribe({"twitch": ["Announcement"]}, func(payload): announcement.emit(payload))
	StreamerBot.subscribe({"twitch": ["AdRun"]}, func(payload): ad_run.emit(payload))
	StreamerBot.subscribe({"twitch": ["BotWhisper"]}, func(payload): bot_whisper.emit(payload))
	StreamerBot.subscribe({"twitch": ["CharityDonation"]}, func(payload): charity_donation.emit(payload))
	StreamerBot.subscribe({"twitch": ["CharityCompleted"]}, func(payload): charity_completed.emit(payload))
	StreamerBot.subscribe({"twitch": ["CoinCheer"]}, func(payload): coin_cheer.emit(payload))
	StreamerBot.subscribe({"twitch": ["ShoutoutCreated"]}, func(payload): shoutout_created.emit(payload))
	StreamerBot.subscribe({"twitch": ["UserUntimedOut"]}, func(payload): user_untimed_out.emit(payload))
	StreamerBot.subscribe({"twitch": ["CharityStarted"]}, func(payload): charity_started.emit(payload))
	StreamerBot.subscribe({"twitch": ["CharityProgress"]}, func(payload): charity_progress.emit(payload))
	StreamerBot.subscribe({"twitch": ["GoalBegin"]}, func(payload): goal_begin.emit(payload))
	StreamerBot.subscribe({"twitch": ["GoalProgress"]}, func(payload): goal_progress.emit(payload))
	StreamerBot.subscribe({"twitch": ["GoalEnd"]}, func(payload): goal_end.emit(payload))
	StreamerBot.subscribe({"twitch": ["ShieldModeBegin"]}, func(payload): shield_mode_begin.emit(payload))
	StreamerBot.subscribe({"twitch": ["ShieldModeEnd"]}, func(payload): shield_mode_end.emit(payload))
	StreamerBot.subscribe({"twitch": ["AdMidRoll"]}, func(payload): ad_mid_roll.emit(payload))
	StreamerBot.subscribe({"twitch": ["StreamOnline"]}, func(payload): stream_online.emit(payload))
	StreamerBot.subscribe({"twitch": ["StreamOffline"]}, func(payload): stream_offline.emit(payload))
	StreamerBot.subscribe({"twitch": ["ShoutoutReceived"]}, func(payload): shoutout_received.emit(payload))
	StreamerBot.subscribe({"twitch": ["ChatCleared"]}, func(payload): chat_cleared.emit(payload))
	StreamerBot.subscribe({"twitch": ["RaidStart"]}, func(payload): raid_start.emit(payload))
	StreamerBot.subscribe({"twitch": ["RaidSend"]}, func(payload): raid_send.emit(payload))
	StreamerBot.subscribe({"twitch": ["RaidCancelled"]}, func(payload): raid_cancelled.emit(payload))
	StreamerBot.subscribe({"twitch": ["PollTerminated"]}, func(payload): poll_terminated.emit(payload))
	StreamerBot.subscribe({"twitch": ["PyramidSuccess"]}, func(payload): pyramid_success.emit(payload))
	StreamerBot.subscribe({"twitch": ["PyramidBroken"]}, func(payload): pyramid_broken.emit(payload))
	StreamerBot.subscribe({"twitch": ["ViewerCountUpdate"]}, func(payload): viewer_count_update.emit(payload))
	StreamerBot.subscribe({"twitch": ["GuestStarSessionBegin"]}, func(payload): guest_star_session_begin.emit(payload))
	StreamerBot.subscribe({"twitch": ["GuestStarSessionEnd"]}, func(payload): guest_star_session_end.emit(payload))
	StreamerBot.subscribe({"twitch": ["GuestStarGuestUpdate"]}, func(payload): guest_star_guest_update.emit(payload))
	StreamerBot.subscribe({"twitch": ["GuestStarSlotUpdate"]}, func(payload): guest_star_slot_update.emit(payload))
	StreamerBot.subscribe({"twitch": ["GuestStarSettingsUpdate"]}, func(payload): guest_star_settings_update.emit(payload))
	StreamerBot.subscribe({"twitch": ["HypeChat"]}, func(payload): hype_chat.emit(payload))
	StreamerBot.subscribe({"twitch": ["RewardRedemptionUpdated"]}, func(payload): reward_redemption_updated.emit(payload))
	StreamerBot.subscribe({"twitch": ["HypeChatLevel"]}, func(payload): hype_chat_level.emit(payload))
	StreamerBot.subscribe({"twitch": ["BroadcasterAuthenticated"]}, func(payload): broadcaster_authenticated.emit(payload))
	StreamerBot.subscribe({"twitch": ["BroadcasterChatConnected"]}, func(payload): broadcaster_chat_connected.emit(payload))
	StreamerBot.subscribe({"twitch": ["BroadcasterChatDisconnected"]}, func(payload): broadcaster_chat_disconnected.emit(payload))
	StreamerBot.subscribe({"twitch": ["BroadcasterPubSubConnected"]}, func(payload): broadcaster_pub_sub_connected.emit(payload))
	StreamerBot.subscribe({"twitch": ["BroadcasterPubSubDisconnected"]}, func(payload): broadcaster_pub_sub_disconnected.emit(payload))
	StreamerBot.subscribe({"twitch": ["BroadcasterEventSubConnected"]}, func(payload): broadcaster_event_sub_connected.emit(payload))
	StreamerBot.subscribe({"twitch": ["BroadcasterEventSubDisconnected"]}, func(payload): broadcaster_event_sub_disconnected.emit(payload))
	StreamerBot.subscribe({"twitch": ["SevenTVEmoteAdded"]}, func(payload): seven_tv_emote_added.emit(payload))
	StreamerBot.subscribe({"twitch": ["SevenTVEmoteRemoved"]}, func(payload): seven_tv_emote_removed.emit(payload))
	StreamerBot.subscribe({"twitch": ["BetterTTVEmoteAdded"]}, func(payload): better_ttv_emote_added.emit(payload))
	StreamerBot.subscribe({"twitch": ["BetterTTVEmoteRemoved"]}, func(payload): better_ttv_emote_removed.emit(payload))
	StreamerBot.subscribe({"twitch": ["BotEventSubConnected"]}, func(payload): bot_event_sub_connected.emit(payload))
	StreamerBot.subscribe({"twitch": ["BotEventSubDisconnected"]}, func(payload): bot_event_sub_disconnected.emit(payload))
	StreamerBot.subscribe({"twitch": ["UpcomingAd"]}, func(payload): upcoming_ad.emit(payload))
	StreamerBot.subscribe({"twitch": ["ModeratorAdded"]}, func(payload): moderator_added.emit(payload))
	StreamerBot.subscribe({"twitch": ["ModeratorRemoved"]}, func(payload): moderator_removed.emit(payload))
	StreamerBot.subscribe({"twitch": ["VipAdded"]}, func(payload): vip_added.emit(payload))
	StreamerBot.subscribe({"twitch": ["VipRemoved"]}, func(payload): vip_removed.emit(payload))
	StreamerBot.subscribe({"twitch": ["UserUnbanned"]}, func(payload): user_unbanned.emit(payload))
	StreamerBot.subscribe({"twitch": ["UnbanRequestApproved"]}, func(payload): unban_request_approved.emit(payload))
	StreamerBot.subscribe({"twitch": ["UnbanRequestDenied"]}, func(payload): unban_request_denied.emit(payload))
	StreamerBot.subscribe({"twitch": ["AutomaticRewardRedemption"]}, func(payload): automatic_reward_redemption.emit(payload))
	StreamerBot.subscribe({"twitch": ["UnbanRequestCreated"]}, func(payload): unban_request_created.emit(payload))
	StreamerBot.subscribe({"twitch": ["ChatEmoteModeOn"]}, func(payload): chat_emote_mode_on.emit(payload))
	StreamerBot.subscribe({"twitch": ["ChatEmoteModeOff"]}, func(payload): chat_emote_mode_off.emit(payload))
	StreamerBot.subscribe({"twitch": ["ChatFollowerModeOn"]}, func(payload): chat_follower_mode_on.emit(payload))
	StreamerBot.subscribe({"twitch": ["ChatFollowerModeOff"]}, func(payload): chat_follower_mode_off.emit(payload))
	StreamerBot.subscribe({"twitch": ["ChatFollowerModeChanged"]}, func(payload): chat_follower_mode_changed.emit(payload))
	StreamerBot.subscribe({"twitch": ["ChatSlowModeOn"]}, func(payload): chat_slow_mode_on.emit(payload))
	StreamerBot.subscribe({"twitch": ["ChatSlowModeOff"]}, func(payload): chat_slow_mode_off.emit(payload))
	StreamerBot.subscribe({"twitch": ["ChatSlowModeChanged"]}, func(payload): chat_slow_mode_changed.emit(payload))
	StreamerBot.subscribe({"twitch": ["ChatSubscriberModeOn"]}, func(payload): chat_subscriber_mode_on.emit(payload))
	StreamerBot.subscribe({"twitch": ["ChatSubscriberModeOff"]}, func(payload): chat_subscriber_mode_off.emit(payload))
	StreamerBot.subscribe({"twitch": ["ChatUniqueModeOn"]}, func(payload): chat_unique_mode_on.emit(payload))
	StreamerBot.subscribe({"twitch": ["ChatUniqueModeOff"]}, func(payload): chat_unique_mode_off.emit(payload))
	StreamerBot.subscribe({"twitch": ["AutoModMessageHeld"]}, func(payload): auto_mod_message_held.emit(payload))
	StreamerBot.subscribe({"twitch": ["AutoModMessageUpdate"]}, func(payload): auto_mod_message_update.emit(payload))
	StreamerBot.subscribe({"twitch": ["BlockedTermsAdded"]}, func(payload): blocked_terms_added.emit(payload))
	StreamerBot.subscribe({"twitch": ["BlockedTermsDeleted"]}, func(payload): blocked_terms_deleted.emit(payload))
	StreamerBot.subscribe({"twitch": ["WarnedUser"]}, func(payload): warned_user.emit(payload))
	StreamerBot.subscribe({"twitch": ["SuspiciousUserUpdate"]}, func(payload): suspicious_user_update.emit(payload))
	StreamerBot.subscribe({"twitch": ["PermittedTermsAdded"]}, func(payload): permitted_terms_added.emit(payload))
	StreamerBot.subscribe({"twitch": ["PermittedTermsDeleted"]}, func(payload): permitted_terms_deleted.emit(payload))
	StreamerBot.subscribe({"twitch": ["WarningAcknowledged"]}, func(payload): warning_acknowledged.emit(payload))
	StreamerBot.subscribe({"twitch": ["WatchStreak"]}, func(payload): watch_streak.emit(payload))
	StreamerBot.subscribe({"twitch": ["PollArchived"]}, func(payload): poll_archived.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatSessionBegin"]}, func(payload): shared_chat_session_begin.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatSessionUpdate"]}, func(payload): shared_chat_session_update.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatSessionEnd"]}, func(payload): shared_chat_session_end.emit(payload))
	StreamerBot.subscribe({"twitch": ["PrimePaidUpgrade"]}, func(payload): prime_paid_upgrade.emit(payload))
	StreamerBot.subscribe({"twitch": ["PayItForward"]}, func(payload): pay_it_forward.emit(payload))
	StreamerBot.subscribe({"twitch": ["GiftPaidUpgrade"]}, func(payload): gift_paid_upgrade.emit(payload))
	StreamerBot.subscribe({"twitch": ["BitsBadgeTier"]}, func(payload): bits_badge_tier.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatAnnouncement"]}, func(payload): shared_chat_announcement.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatRaid"]}, func(payload): shared_chat_raid.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatPrimePaidUpgrade"]}, func(payload): shared_chat_prime_paid_upgrade.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatGiftPaidUpgrade"]}, func(payload): shared_chat_gift_paid_upgrade.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatPayItForward"]}, func(payload): shared_chat_pay_it_forward.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatSub"]}, func(payload): shared_chat_sub.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatResub"]}, func(payload): shared_chat_resub.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatSubGift"]}, func(payload): shared_chat_sub_gift.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatCommunitySubGift"]}, func(payload): shared_chat_community_sub_gift.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatUserBanned"]}, func(payload): shared_chat_user_banned.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatUserUnbanned"]}, func(payload): shared_chat_user_unbanned.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatUserTimedout"]}, func(payload): shared_chat_user_timedout.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatUserUntimedout"]}, func(payload): shared_chat_user_untimedout.emit(payload))
	StreamerBot.subscribe({"twitch": ["SharedChatMessageDeleted"]}, func(payload): shared_chat_message_deleted.emit(payload))
