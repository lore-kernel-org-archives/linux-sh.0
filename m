From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 May 2009 11:25:57 +0000
Subject: [PATCH] sh: sh_dac_audio fixes
Message-Id: <20090514112557.27985.47363.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch modifies sh_dac_audio in the following ways:
- use high resolution timer instead of TMU1
- fix cpu/dac.h include
- add CONFIG_SH_HP6XX ifdefs
- add future rewrite comment

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 sound/oss/Kconfig        |    2 -
 sound/oss/sh_dac_audio.c |   81 +++++++++++++++++-----------------------------
 2 files changed, 32 insertions(+), 51 deletions(-)

--- 0001/sound/oss/Kconfig
+++ work/sound/oss/Kconfig	2009-05-14 19:14:45.000000000 +0900
@@ -561,7 +561,7 @@ endif	# SOUND_OSS
 
 config SOUND_SH_DAC_AUDIO
 	tristate "SuperH DAC audio support"
-	depends on CPU_SH3
+	depends on CPU_SH3 && HIGH_RES_TIMERS
 
 config SOUND_SH_DAC_AUDIO_CHANNEL
 	int "DAC channel"
--- 0001/sound/oss/sh_dac_audio.c
+++ work/sound/oss/sh_dac_audio.c	2009-05-14 19:13:48.000000000 +0900
@@ -18,47 +18,36 @@
 #include <linux/sound.h>
 #include <linux/soundcard.h>
 #include <linux/interrupt.h>
+#include <linux/hrtimer.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/irq.h>
 #include <asm/delay.h>
 #include <asm/clock.h>
-#include <asm/cpu/dac.h>
-#include <asm/cpu/timer.h>
+#include <cpu/dac.h>
 #include <asm/machvec.h>
 #include <mach/hp6xx.h>
 #include <asm/hd64461.h>
 
 #define MODNAME "sh_dac_audio"
 
-#define TMU_TOCR_INIT	0x00
-
-#define TMU1_TCR_INIT	0x0020	/* Clock/4, rising edge; interrupt on */
-#define TMU1_TSTR_INIT  0x02	/* Bit to turn on TMU1 */
-
 #define BUFFER_SIZE 48000
 
 static int rate;
 static int empty;
 static char *data_buffer, *buffer_begin, *buffer_end;
 static int in_use, device_major;
+static struct hrtimer hrtimer;
+static ktime_t wakeups_per_second;
 
 static void dac_audio_start_timer(void)
 {
-	u8 tstr;
-
-	tstr = ctrl_inb(TMU_TSTR);
-	tstr |= TMU1_TSTR_INIT;
-	ctrl_outb(tstr, TMU_TSTR);
+	hrtimer_start(&hrtimer, wakeups_per_second, HRTIMER_MODE_REL);
 }
 
 static void dac_audio_stop_timer(void)
 {
-	u8 tstr;
-
-	tstr = ctrl_inb(TMU_TSTR);
-	tstr &= ~TMU1_TSTR_INIT;
-	ctrl_outb(tstr, TMU_TSTR);
+	hrtimer_cancel(&hrtimer);
 }
 
 static void dac_audio_reset(void)
@@ -76,39 +65,33 @@ static void dac_audio_sync(void)
 
 static void dac_audio_start(void)
 {
+#ifdef CONFIG_SH_HP6XX
 	if (mach_is_hp6xx()) {
 		u16 v = inw(HD64461_GPADR);
 		v &= ~HD64461_GPADR_SPEAKER;
 		outw(v, HD64461_GPADR);
 	}
-
+#endif
 	sh_dac_enable(CONFIG_SOUND_SH_DAC_AUDIO_CHANNEL);
-	ctrl_outw(TMU1_TCR_INIT, TMU1_TCR);
 }
 static void dac_audio_stop(void)
 {
 	dac_audio_stop_timer();
 
+#ifdef CONFIG_SH_HP6XX
 	if (mach_is_hp6xx()) {
 		u16 v = inw(HD64461_GPADR);
 		v |= HD64461_GPADR_SPEAKER;
 		outw(v, HD64461_GPADR);
 	}
-
+#endif
  	sh_dac_output(0, CONFIG_SOUND_SH_DAC_AUDIO_CHANNEL);
 	sh_dac_disable(CONFIG_SOUND_SH_DAC_AUDIO_CHANNEL);
 }
 
 static void dac_audio_set_rate(void)
 {
-	unsigned long interval;
- 	struct clk *clk;
-
- 	clk = clk_get(NULL, "module_clk");
- 	interval = (clk_get_rate(clk) / 4) / rate;
- 	clk_put(clk);
-	ctrl_outl(interval, TMU1_TCOR);
-	ctrl_outl(interval, TMU1_TCNT);
+	wakeups_per_second = ktime_set(0, 1000000000 / rate);
 }
 
 static int dac_audio_ioctl(struct inode *inode, struct file *file,
@@ -265,32 +248,26 @@ const struct file_operations dac_audio_f
       .release =	dac_audio_release,
 };
 
-static irqreturn_t timer1_interrupt(int irq, void *dev)
+static enum hrtimer_restart sh_dac_audio_timer(struct hrtimer *handle)
 {
-	unsigned long timer_status;
-
-	timer_status = ctrl_inw(TMU1_TCR);
-	timer_status &= ~0x100;
-	ctrl_outw(timer_status, TMU1_TCR);
-
 	if (!empty) {
 		sh_dac_output(*buffer_begin, CONFIG_SOUND_SH_DAC_AUDIO_CHANNEL);
 		buffer_begin++;
 
 		if (buffer_begin = data_buffer + BUFFER_SIZE)
 			buffer_begin = data_buffer;
-		if (buffer_begin = buffer_end) {
+		if (buffer_begin = buffer_end)
 			empty = 1;
-			dac_audio_stop_timer();
-		}
 	}
-	return IRQ_HANDLED;
+
+	if (!empty)
+		hrtimer_start(&hrtimer, wakeups_per_second, HRTIMER_MODE_REL);
+
+	return HRTIMER_NORESTART;
 }
 
 static int __init dac_audio_init(void)
 {
-	int retval;
-
 	if ((device_major = register_sound_dsp(&dac_audio_fops, -1)) < 0) {
 		printk(KERN_ERR "Cannot register dsp device");
 		return device_major;
@@ -306,21 +283,25 @@ static int __init dac_audio_init(void)
 	rate = 8000;
 	dac_audio_set_rate();
 
-	retval -	    request_irq(TIMER1_IRQ, timer1_interrupt, IRQF_DISABLED, MODNAME, 0);
-	if (retval < 0) {
-		printk(KERN_ERR "sh_dac_audio: IRQ %d request failed\n",
-		       TIMER1_IRQ);
-		return retval;
-	}
+	/* Today: High Resolution Timer driven DAC playback.
+	 * The timer callback gets called once per sample. Ouch.
+	 *
+	 * Future: A much better approach would be to use the
+	 * SH7720 CMT+DMAC+DAC hardware combination like this:
+	 * - Program sample rate using CMT0 or CMT1
+	 * - Program DMAC to use CMT for timing and output to DAC
+	 * - Play sound using DMAC, let CPU sleep.
+	 * - While at it, rewrite this driver to use ALSA.
+	 */
+
+	hrtimer_init(&hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer.function = sh_dac_audio_timer;
 
 	return 0;
 }
 
 static void __exit dac_audio_exit(void)
 {
-	free_irq(TIMER1_IRQ, 0);
-
 	unregister_sound_dsp(device_major);
 	kfree((void *)data_buffer);
 }
