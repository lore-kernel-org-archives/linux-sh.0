From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 14 Mar 2013 12:54:11 +0000
Subject: Re: [PATCH v4 00/88] PFC pinctrl functions for sh7372, sh73a0, r8a7740 and r8a7779
Message-Id: <2240978.MXCESHIJiU@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1363215633-4264-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1363215633-4264-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thursday 14 March 2013 10:46:55 Simon Horman wrote:

[snip]

> I am seeing (a hopefully minor) problem which is using the defconfigs for
> the armadillo800eva I see:
> 
> fbdev-laurent
> 
> I believe this applies at least to all the other arm-based boards too.
> 
> drivers/built-in.o:(.rodata+0xa4): undefined reference to
> `pinconf_generic_dump_config'
> 
> It seems like some Kconfig updates might be in order.

I see two ways to fix this but I'm not sure which one is best. The first one
handles the issue in the pinctrl core:

diff --git a/drivers/pinctrl/pinconf.h b/drivers/pinctrl/pinconf.h
index 1f7113e..971636d 100644
--- a/drivers/pinctrl/pinconf.h
+++ b/drivers/pinctrl/pinconf.h
@@ -90,7 +90,7 @@ static inline void pinconf_init_device_debugfs(struct dentry *devroot,
  * pin config.
  */
 
-#ifdef CONFIG_GENERIC_PINCONF
+#if defined(CONFIG_GENERIC_PINCONF) && defined (CONFIG_DEBUG_FS)
 
 void pinconf_generic_dump_pin(struct pinctrl_dev *pctldev,
 			      struct seq_file *s, unsigned pin);

And the second one in the PFC driver:

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index aef268b..b5ec109 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -365,7 +365,9 @@ static const struct pinconf_ops sh_pfc_pinconf_ops = {
 	.pin_config_get			= sh_pfc_pinconf_get,
 	.pin_config_set			= sh_pfc_pinconf_set,
 	.pin_config_group_set		= sh_pfc_pinconf_group_set,
+#ifdef CONFIG_DEBUG_FS
 	.pin_config_config_dbg_show	= pinconf_generic_dump_config,
+#endif
 };
 
 /* PFC ranges -> pinctrl pin descs */

Linus, what's your opinion?

-- 
Regards,

Laurent Pinchart

