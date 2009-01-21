From: Paul Brook <paul@codesourcery.com>
Date: Wed, 21 Jan 2009 17:06:06 +0000
Subject: Re: [Qemu-devel] [PATCH 1/3] sh: SE7750 board definition
Message-Id: <200901211706.09350.paul@codesourcery.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4969B77E.7050206@juno.dti.ne.jp>
	<20090121090424.GC14537@linux-sh.org>
	<4977527A.70104@juno.dti.ne.jp>
In-Reply-To: <4977527A.70104@juno.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: qemu-devel@nongnu.org
Cc: Takashi Yoshii <yoshii.takashi@renesas.com>, Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

> Now, I hope that we would reach a consensus about the spec of new standard
> board for SH-4A.  SH7785LCR is a choice.  And, as Iwamatsu-san suggested, a
> virtual generic board is another choice.  I'm not sure SH7785LCR's hardware
> spec is available or not. (Does anyone know it?)  If it is, I push
> SH7785LCR.  Otherwise, virtual board sounds good.

I recommend against using a virtual board. It means you have to maintain both 
qemu and a kernel port. The mips virtual board suffered exactly this fate, 
and IIUC is likely to be removed fairly soon.

Paul
