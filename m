From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 14 Jun 2013 14:29:26 +0000
Subject: Re: [PATCH 14/15] ARM: shmobile: Remove AP4EVB board support
Message-Id: <201306141629.26580.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
 <Pine.LNX.4.64.1306132128370.3777@axis700.grange>
 <CANqRtoSx4Jf_EfG3LvkpoOED4-SuOdWjRedz-RbwGCOcOeP-Xg@mail.gmail.com>
In-Reply-To: <CANqRtoSx4Jf_EfG3LvkpoOED4-SuOdWjRedz-RbwGCOcOeP-Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 14 June 2013, Magnus Damm wrote:
> > If still possible, would be good to delay removing this board until we
> > complete our discussion.
> 
> If fine with keeping the board if someone can show me progress in the
> area of INTC DT support. Recently I have not seen anything.

As mentioned the last time we discussed this, I'm fine with using the
existing code and "legacy" irqdomain for the older INTC implementations,
as long as all the new ones can use your new generic code.

	Arnd
