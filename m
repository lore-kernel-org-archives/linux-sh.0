From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 30 Oct 2014 17:41:10 +0000
Subject: Re: [PATCH v3 7/7] ARM: shmobile: kzm9g-reference: require ZB clock for Ethernet controller
Message-Id: <CAO3366zQJ10-fSg5-twO3D4t7J19DUxbY_=7=e4xCjVrupUFJw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414515736-24905-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1414515736-24905-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 29, 2014 at 1:21 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Oct 28, 2014 at 06:02:16PM +0100, Ulrich Hecht wrote:
>> Unlike the legacy stuff, CCF disables the ethernet controller's clock
>> unless it is used somewhere.
>
> This feels like it should come earlier in the series to avoid
> breaking then fixing ethernet support for kzm9g-reference.

The CCF support, not being used yet, doesn't actually break anything.
The reason this patch is separated from the rest is that it works, but
it's not completely clear (to me) how.

As Laurent has pointed out before, the LAN controller is not
(directly) hooked up to this clock, but to an external oscillator.
Nonetheless Ethernet won't work unless ZB is on, which I have
determined by trial and error. Maybe that should have been pointed out
in the description...

CU
Uli
