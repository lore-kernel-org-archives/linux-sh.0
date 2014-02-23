From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sun, 23 Feb 2014 19:09:48 +0000
Subject: Re: [PATCH] gpio: gpio-rcar: init at postcore level
Message-Id: <530A477C.6070007@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1393173467-12240-1-git-send-email-vladimir.barinov@cogentembedded.com>
In-Reply-To: <1393173467-12240-1-git-send-email-vladimir.barinov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 23/02/14 16:37, vladimir.barinov@cogentembedded.com wrote:
> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>
> This adds ability to use gpio API at board init_machine level.
>
> F.e. it can be used in the following situation.
> Many reference hardware has onboard switches that selects which periferals
> to connect to the system. The gpio input state from switches can be used
> in choosing platform devices runtime in board code instead of ifdefs/defconfig
> changes.

Firstly, anyone still using platform_devices to describe their
system needs to be stopped. We cannot go on supporting this when
our primary boot method is supposed to be device-tree. If we keep
doing this then we will not get any of the current issues fixed.

Will it impact the devicetree bindings on rcar?


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
