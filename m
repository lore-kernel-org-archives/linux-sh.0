From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Sat, 24 Jan 2009 05:46:40 +0000
Subject: sh: Virtual Board or Real board? (was Re: [Qemu-devel] [PATCH 1/3]
Message-Id: <497AAB40.7010608@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <4969B77E.7050206@juno.dti.ne.jp>	<20090121090424.GC14537@linux-sh.org>	<4977527A.70104@juno.dti.ne.jp>
	<200901211706.09350.paul@codesourcery.com>
In-Reply-To: <200901211706.09350.paul@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: qemu-devel@nongnu.org
Cc: Takashi Yoshii <yoshii.takashi@renesas.com>, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Paul Brook wrote:
>> Now, I hope that we would reach a consensus about the spec of new standard
>> board for SH-4A.  SH7785LCR is a choice.  And, as Iwamatsu-san suggested, a
>> virtual generic board is another choice.  I'm not sure SH7785LCR's hardware
>> spec is available or not. (Does anyone know it?)  If it is, I push
>> SH7785LCR.  Otherwise, virtual board sounds good.
> 
> I recommend against using a virtual board. It means you have to maintain both 
> qemu and a kernel port. The mips virtual board suffered exactly this fate, 
> and IIUC is likely to be removed fairly soon.

Thank you for your comment.  As you pointed out, we need to maintain kernel
config for virtual board.  SH-Linux developpers' help is important.
I guess we can expect Iwamatsu-san's help :)  And once Paul Mundt
supported special kernel configuration for QEMU-SH kindly.


I try to clarify the difference of real board and virtual board, as follows.

* Real board

- We can compare the emulated system with the real board.  The specification
  is not vague, and deffects can be investitated by comaparison.

- No need to maintain kernel, and it can avoid the risk the maintenance
  work would be terminated, as Paul Brook pointed out.


* Virtual board

- It decreases the number of supported boards, and avoid messy many board
  supports.  SuperH series have many CPU sub tyepes, and as number of
  supported CPU types increase, number of suppoted boards will increase.
  (Iwamatsu-san pointed it out.)

- It avoids rare peripheral support by QEMU.
  Sometimes embedded boards have rare peripheral on it.
     e.g.) RTL8139B (below Rev.C). on R2D+.
           http://lists.gnu.org/archive/html/qemu-devel/2008-12/msg00961.html
  If we make the virtual board have standard peripheral (e.g. RTL8139C),
  we can reuse peripheral implemenation qualified with other board for other
  CPU arch, and avoid messy many type peripheral support.

I'm not sure if QEMU's policy exists or not for this kind of choice.

We can support both of them in the future.  But I think it is important
to make consensus which should be the default and standard for QEMU-SH,
to decide to which we'll try to contribute.

I'd like to your comments on them.


Regards,
Shin-ichiro KAWASAKI


