From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Thu, 24 Mar 2016 11:40:15 +0000
Subject: Re: Availability of SH hardware?
Message-Id: <87wpos9k9s.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317032441.GA22517@brightrain.aerifal.cx>
In-Reply-To: <20160317032441.GA22517@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 17 Mar 2016 12:24:41 +0900,
Rich Felker wrote:
> 
> One of my goals in taking on maintainership of arch/sh is to gradually
> replace all of the hard-coded legacy board/subtype support with device
> tree based board descriptions, and clean up the related board support
> infrastructure in arch/sh to be more in line with how things are done
> on other archs these days. However the ability to make and test these
> changes depends on having some actual hardware to work with.
> 
> I'm working on the J-Core (currently J2) open hardware revival of the
> SH architecture and don't have any original SH hardware (except
> perhaps embedded in old appliances). Does anyone have pointers (direct
> add-to-cart'able links) to where SH dev boards are still available, or
> even better, any old hardware lying around that's not being used that
> you'd be willing to donate?
> 
> I'm especially interested in getting an SH-X3 board since it seems to
> be the only model with existing SMP support, and moving it over to
> device tree would eliminate the need for keeping around the
> non-device-tree SMP register_smp_ops and cross-core cache invalidation
> infrastructure, which are low-hanging fruit for refactoring/cleanup.
> But really anything would be great to have.
> 
> Rich
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I got HDL-U (aka LANDISK). And setup latest u-boot / kernel.
So we can testing real SH4 hardware.

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
