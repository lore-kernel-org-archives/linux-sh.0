From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 08 Jan 2013 17:58:37 +0000
Subject: Re: [PATCH 00/22] SH pinctrl and pinmux implementation
Message-Id: <135769355.UnjMLfJSta@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1357237073-15600-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1357237073-15600-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Tuesday 08 January 2013 10:49:32 Linus Walleij wrote:
> On Mon, Jan 7, 2013 at 2:27 PM, Laurent Pinchart wrote:
> > Would you have time to share your thoughts about the following issue
> > (copied from the cover letter of this patch series) ?
> > 
> > I ran into an issue when trying to port the bonito board (the only other
> > r8a7740 board in mainline) to the pinmux API. My board patches use system
> > pin control hogging to apply the initial pinmux configuration. This
> > mechanism requires registering the pinctrl mappings before registering
> > the pinctrl device, as the default states are selected when the pinctrl
> > device is registered. However, the mappings vary depending on board
> > configuration read through GPIOs, and the GPIOs are implemented by the
> > pinctrl driver. One possible solution would be to apply updates to the
> > selected state as mappings are registered, but that looks pretty complex
> > at first sight. Other ideas (or, better, patches :-)) are welcome.
> 
> Hm, yes today we require that mappings be in place before the pinctrl driver
> is registered in order for hogs to work.
> 
> With device tree I guess the problem goes away.
> 
> But I guess for those not using device tree it'd be nice to modify the map
> registration function to check if something needs to be hogged by an already
> existing device at that point. If you write a patch for this we can discuss
> it...
>
> There is another issue making it desireable to have mappings registered as
> early as possible, and that is my patch moving default pinctrl grabbing into
> the device core, but generally of course all devices need their maps in
> place before probing anyway.

That's exactly what I need :-) With that patch in place I can register the 
pinctrl device before registering the mappings, as long as the mappings are 
registered before their associated device.

Is there a chance the patch will make it to v3.9 ?

-- 
Regards,

Laurent Pinchart

