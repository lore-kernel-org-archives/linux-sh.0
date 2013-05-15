From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 15 May 2013 12:52:23 +0000
Subject: Re: marzen pinctl conflict for renesas-next-20130515v2 + v3.10-rc1
Message-Id: <51938507.8010306@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130515084658.GA19115@verge.net.au>
In-Reply-To: <20130515084658.GA19115@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 15-05-2013 16:38, Laurent Pinchart wrote:

>>> I am preparing to rebase the branches of the renesas tree which
>>> are targeted for v3.11 on top of v3.10-rc1. In the course of
>>> doing so I have noticed a problem on the marzen board which appears
>>> to be related to pinmux.

>>> On boot, using the default config I see the following:

>>> sh-pfc pfc-r8a7779: pin GP_4_22 already requested by sh-hspi.0; cannot
>>> claim for ehci-platform.0 sh-pfc pfc-r8a7779: pin-150 (ehci-platform.0)
>>> status -22
>>> sh-pfc pfc-r8a7779: could not request pin 150 on device sh-pfc

>> I have already reported this. Laurent prepared a fix, which I somewhat
>> criticized, but he never published a second version.

> I've posted v2 earlier today.

    Saw it after replying to Simon, thanks.

WBR, Sergei

