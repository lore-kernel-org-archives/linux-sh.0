From: Bui Duc Phuc <bd-phuc@jinso.co.jp>
Date: Mon, 12 Sep 2016 00:25:52 +0000
Subject: Re: [PATCH 7/8] clocksource: Kconfig: Modify CMT config support 64bit
Message-Id: <6c81d16a-85de-f49f-af66-7d80f1aa3eb4@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1473421394-9745-1-git-send-email-bd-phuc@jinso.co.jp>
 <1473421394-9745-8-git-send-email-bd-phuc@jinso.co.jp>
 <4193048.IXigyaYqrQ@avalon>
In-Reply-To: <4193048.IXigyaYqrQ@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Laurent

Thank you for your comments.
> I think you should instead add
>
> 	select SH_TIMER_CMT
>
> to the config ARCH_RENESAS section in arch/arm64/Kconfig.platforms
I will update in V2.

-- 
Regards,

Bui Duc Phuc

