LIT AUDIO_BANK #3

LIT HIGHPASS_REG #0
LIT LOWPASS_REG #1
LIT WAVEFORM_REG #2
LIT PULSE_WIDTH_REG #3
LIT NOTE_REG #4
LIT PITCH_BEND_REG #5
LIT PHASE_REG #6
LIT VOLUME_REG #7

LIT PULSE_WAVE    #%00
LIT SAW_WAVE      #%01
LIT TRIANGLE_WAVE #%10
LIT NOISE_WAVE    #%11

ADR BANK_SELECTOR $AFFF
ADR OSC_SELECTOR $B002
ADR AUDIO_REG_SELECTOR $B003
ADR AUDIO_REG_VALUE $B004

STR		AUDIO_BANK		BANK_SELECTOR	 	; switch to audio bank
STR		#0	 			OSC_SELECTOR 		; switch to oscillator 0
STR		WAVEFORM_REG	AUDIO_REG_SELECTOR 	; switch to waveform register
STR		PULSE_WAVE		AUDIO_REG_VALUE 	; set to pulse
STR		LOWPASS_REG 	AUDIO_REG_SELECTOR 	; switch to lowpass register
STR		#$FF			AUDIO_REG_VALUE 	; set to off
STR		PULSE_WIDTH_REG	AUDIO_REG_SELECTOR 	; switch to pulse width register
STR		#$80			AUDIO_REG_VALUE 	; set to 50% (128)
STR		NOTE_REG		AUDIO_REG_SELECTOR 	; switch to note register
STR		#49				AUDIO_REG_VALUE		; set note to 49 (C4)
STR		#37				AUDIO_REG_VALUE		; set note to 37 (C3)
STR		VOLUME_REG		AUDIO_REG_SELECTOR	; switch to volume register
STR		#$40			AUDIO_REG_VALUE		; set to 25% (64)

:LOOP
JMP		:LOOP
