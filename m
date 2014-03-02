From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 02 Mar 2014 10:36:29 +0000
Subject: Re: [PATCH v2 14/40] clocksource: sh_cmt: Set cpumask to cpu_possible_mask
Message-Id: <2942338.46QFBXXizV@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1393603090-23144-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1393603090-23144-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the review.

On Saturday 01 March 2014 18:52:00 Geert Uytterhoeven wrote:
> Hi Laurent,
> 
> On Fri, Feb 28, 2014 at 4:57 PM, Laurent Pinchart
> 
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
> > On UP systems no dummy timer is instantiated. The CMT timer has a rating
> > of 125 on those systems and is used directly a clock event device for
> 
> as clock event device.

I'll fix that in v3.

> > CPU0 without broadcasting.

-- 
Regards,

Laurent Pinchart

