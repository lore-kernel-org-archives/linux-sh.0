From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 17 Jan 2011 08:55:28 +0000
Subject: Re: Booting kernel 2.6.37+ for renesas sh on sh2a 7203
Message-Id: <20110117085528.GD2122@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201101161739.57933.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101161739.57933.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 17, 2011 at 09:55:15AM +0100, Fabio Giovagnini wrote:
> Thanks Paul for your answer.
> Did you use uBoot for booting, or the MCP data bootloader?
> 
The only boards I have all have uboot on them. The uboot version I use is
a bit buggy though so I often have to use trimmed down kernels for the
decompression to succeed (Iwamatsu-san did the initial port as I recall,
and I don't think its had much attention since then). I'm unaware of
whether other versions of the board have the same issues or not. I've
never seen the MPC loader, so if you're using that then of course you
will have to ask them for support.
