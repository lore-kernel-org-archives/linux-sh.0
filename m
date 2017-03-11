From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sat, 11 Mar 2017 08:34:20 +0000
Subject: Re: Bug#576242: gdb: Please support Renesas SH(sh4)
Message-Id: <14608b50-6873-7bec-ebba-1121bed34b10@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <c184d5b5-4ec4-96e8-70f0-3ea61ce480db@physik.fu-berlin.de>
In-Reply-To: <c184d5b5-4ec4-96e8-70f0-3ea61ce480db@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Nobuhiro!

On 03/10/2017 04:16 AM, Nobuhiro Iwamatsu wrote:
> I add Takashi's  to this thread.
> I contacted to Takashi, and talked about this problem.
> He said I would reply on this matter.
> Would you please wait for his reply?

Thank you very much for your initiative. Having native support for
Linux SH in GDB will be very useful for the J-Core project.

Now, I have already talked to the GDB people regarding this matter
and they told me that Yoshii-san needs to sign the copyright assignment
himself [1]. Yao Qi has provided a link which provide the necessary
forms which need to be filled out by Yoshii-san. If he has any problems
choosing the right form or needs additional advise, he can ask on the
gdb-patches mailing list himself [2] or send an email to assign@gnu.org
who will get back to him very quickly.

On a sidenote: Yao Qi just recently happened to talk to Masami Hiramatsu
who happened to have contacted to Yoshii-san at Linaro Connect [3], so
with everyone involved, I am confident to get this resolved soon!

I have one last important question regarding SuperH in general:

Can you make a statement regarding the remaining SH7785LCR boards you
have? Would you still be willing to set these up as buildds? If not,
would it be possible that you hand these boards over to me? I could
receive them in Japan, so they don't have to go abroad.

We desperately need additional buildd hardware for the sh4 port since
we currently have my one SH7785LCR board and two qemu-sh4 instances
running only. I have more hardware (NextVoD boxes) but these currently
lack support for a modern kernel (they are stuck at 2.6.32). It also
doesn't matter if the boards are broken, those are definitely fixable.

Please let's get the buildd issue resolved as well.

Thanks,

Adrian

> [1] https://sourceware.org/ml/gdb-patches/2017-02/msg00507.html
> [2] https://www.gnu.org/software/gdb/mailing-lists/
> [3] https://sourceware.org/ml/gdb-patches/2017-03/msg00127.html

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
