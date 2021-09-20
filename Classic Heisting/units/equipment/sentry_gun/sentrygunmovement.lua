function SentryGunMovement:chk_play_alert(attention, old_attention)
	if not attention and old_attention then
		self._last_attention_t = TimerManager:game():time()
	end

	if attention and not old_attention and TimerManager:game():time() - self._last_attention_t > 3 then

		--self._sound_source:post_event(self._attention_acquired_snd_event)
        managers.menu:relay_chat_message("ZVUK IDK: turreta ", 1)
        log("turret zvuk")
		self._warmup_t = TimerManager:game():time() + 0.5
	end
end