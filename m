From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 14 Oct 2015 12:55:52 +0000
Subject: Re: [PATCH] ARM: shmobile: defconfig: enable HDMI output for RCar
Message-Id: <2387256.Snyt0kyd3C@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1407974835-11064-1-git-send-email-khilman@linaro.org>
In-Reply-To: <1407974835-11064-1-git-send-email-khilman@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday 14 October 2015 19:11:12 Khiem Nguyen wrote:
> On 10/14/2015 3:22 PM, Geert Uytterhoeven wrote:
> > On Wed, Oct 14, 2015 at 10:09 AM, Magnus Damm wrote:
> >>> Or do you mean disabling them upfront?
> >>> There are some clocks that must not be disabled. Some of them are not
> >>> documented.
> >> 
> >> Disabling them upfront with sparse documentation seems fun, but also a
> >> bit like asking for trouble. =)
> > 
> > I have hackish code that does it for all boards I have, and use it
> > actively.
> >
> >> So disabling clocks upfront may be a troublesome but good way to
> >> trigger incorrect dependencies, and unless I'm mistaken it should give
> >> the same behaviour as the updated u-boot version, right?
> > 
> > More or less (U-Boot still keeps a few enabled for its own use, e.g.
> > Ethernet).
>
> AFAIK, in some recent versions of Gen2 BSP, all the devices (including
> all devices enabled by u-boot for its processing, like Ethernet, TMU,
> serial) will be turned off right before jumping to kernel start address.

Would it make sense to keep the serial port enabled in order to support early 
printk ?

-- 
Regards,

Laurent Pinchart

