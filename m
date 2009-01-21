From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Wed, 21 Jan 2009 19:01:35 +0000
Subject: Re: [Qemu-devel] [PATCH 1/3] sh: SE7750 board definition
Message-Id: <20090121190135.GF5147@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4969B77E.7050206@juno.dti.ne.jp>
	<20090111130445.GA12080@game.jcrosoft.org>
	<496ABD72.20400@juno.dti.ne.jp>
	<20090112124949.GA14269@linux-sh.org>
	<496BFD30.30306@renesas.com> <496C98EB.5040309@juno.dti.ne.jp>
	<20090121090424.GC14537@linux-sh.org>
	<4977527A.70104@juno.dti.ne.jp>
In-Reply-To: <4977527A.70104@juno.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Cc: Takashi Yoshii <yoshii.takashi@renesas.com>, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>, qemu-devel@nongnu.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

>> I also don't see much point in catering to OSes that don't support
>> hardware manufactured this century. If the TOPPERS and BSD people want to
>> toy around with legacy support, they are welcome to, but QEMU certainly
>> doesn't have much to gain by spending time on this.
> I've just heard that newest TOPPERS (TOPPERS/ASP) supports SH-4A.
>
>
> Now, I hope that we would reach a consensus about the spec of new standard board
> for SH-4A.  SH7785LCR is a choice.  And, as Iwamatsu-san suggested, a virtual
> generic board is another choice.  I'm not sure SH7785LCR's hardware spec is available
> or not. (Does anyone know it?)  If it is, I push SH7785LCR.  Otherwise, virtual board
> sounds good.
The SH7785LCR is a good choice for the SH-4A
The RSK7203 will be a good choice for the SH-2A

The virtual board will be a good choice for IP test and integration test

Best Regards,
J.
