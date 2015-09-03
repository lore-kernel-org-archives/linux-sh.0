From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 03 Sep 2015 20:47:21 +0000
Subject: Re: [PATCH 0/9] i2c: rcar: tackle race conditions in the driver
Message-Id: <3091262.bFRErFxuqq@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de> <5464456.UnsMOS3MTx@avalon> <20150903204000.GB1574@katana>
In-Reply-To: <20150903204000.GB1574@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hi Wolfram,

On Thursday 03 September 2015 22:40:00 Wolfram Sang wrote:
> >> So I refactored the driver to setup new messages in interrupt context,
> >> too. This avoids the race for b) because we are now setting up the new
> >> message before we release the i2c bus clock (before we released the
> >> clock and set up the message in process context).
> > 
> > Could this fix the HDMI EDID read issue on Koelsch ?
> 
> I surely hope so. I can't test because I don't have Koelsch.

I'll test it ASAP, but that might take a while as I'm busy with VSP+DU on Gen3 
now.

> >> c) is also fixed, this was not a race but a bug in the state handling.
> >> a)> however is not fixed 100% :( We have the race window as small as
> >> possible now when utilizing interrupts, so it is an improvement and
> >> worked for my test cases well. There were experiments by me and Renesas
> >> engineers to use polling to prevent the issue but this caused other side
> >> effects, sadly. So, let's improve the situation now and let's see where
> >> we get.
> > 
> > Does that mean that, due to hardware design, it's impossible to use I2C
> > interrupts in a race-free way ? It would be interesting to document why in
> > a commit log message, or possibly in the code itself.
> 
> It can maybe be done when polling. However, this might need busy looping
> for ~1us. Also, the repeated start handling needs to be rewritten and I
> am not sure this goes well with polling.

I meant without polling. Does the hardware design prevent from using I2C in 
interrupt mode in a race-free way ?

-- 
Regards,

Laurent Pinchart

