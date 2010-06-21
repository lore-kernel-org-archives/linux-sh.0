From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Date: Mon, 21 Jun 2010 07:58:05 +0000
Subject: Re: [PATCH v4 0/4] Add support for new board: SH-2007
Message-Id: <4C1F1B8D.7020803@dcl.info.waseda.ac.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1276858875-10548-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
In-Reply-To: <1276858875-10548-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 06/21/10 15:22, Paul Mundt wrote:
 > Mitake-san,
 >
 > Sorry for the delay, I've been a bit busy with highmem debugging!

No problem at all, thanks for your review!

 >
 > On Fri, Jun 18, 2010 at 08:01:11PM +0900, Hitoshi Mitake wrote:
 >> This patch series add support of SH-2007.
 >> I brought these changes from the out-of-tree kernel
 >> provided by the manufacture of this board, ITO Inc.
 >> Website of company: http://www.itonet.co.jp/
 >> The URL of kernel: http://ms-n.org/sh-linux/kernel/
 >>
 >
 > I've rolled your patches together in to one larger patch and then did
 > some more cosmetic cleanup on it. I've compile tested it and pushed it
 > out, feel free to send additional updates as needed.
 >
 > I removed the stub IDE support for now, but you can of course trivially
 > patch this back in for testing and we can of course add it
 > unconditionally once it's been verified.

Thanks a lot!
I'll try to seek IDE cable for SH-2007 and test it.

 >
 > You can find the final commit here:
 >
 > 
http://git.kernel.org/?p=linux/kernel/git/lethal/sh-2.6.git;a=commitdiff;h:598264436e94c410c413088a7873fcad33616c
 >

