From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 19 Jan 2011 21:52:08 +0000
Subject: Re: Booting kernel 2.6.37+ for renesas sh on sh2a 7203
Message-Id: <201101192252.08891.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201101161739.57933.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101161739.57933.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,
could you write to me please:
1) printenv of your u-boot on rsk+ 7203 you have;
2) bootm report wen you run the uImage?

I'm sure now that the kernel is properly executed but the output is not on 
ttySC0.

What could I check.

Sorry for teh disturb and thanks a lot

Cheers



On Monday 17 January 2011 09:55:28 Paul Mundt wrote:
> On Mon, Jan 17, 2011 at 09:55:15AM +0100, Fabio Giovagnini wrote:
> > Thanks Paul for your answer.
> > Did you use uBoot for booting, or the MCP data bootloader?
> 
> The only boards I have all have uboot on them. The uboot version I use is
> a bit buggy though so I often have to use trimmed down kernels for the
> decompression to succeed (Iwamatsu-san did the initial port as I recall,
> and I don't think its had much attention since then). I'm unaware of
> whether other versions of the board have the same issues or not. I've
> never seen the MPC loader, so if you're using that then of course you
> will have to ask them for support.

-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
