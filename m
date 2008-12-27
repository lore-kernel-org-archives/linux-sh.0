From: SUGIOKA Toshinobu <sugioka@itonet.co.jp>
Date: Sat, 27 Dec 2008 03:02:01 +0000
Subject: Flag T-bit for syscall restart
Message-Id: <4.2.0.58.J.20081227113019.05455988@192.168.0.5>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Could someone explain me about the patch
http://kerneltrap.org/mailarchive/git-commits-head/2008/10/20/3733624

I can't understand why T-bit(regs->sr & 1) is used
as the condition about restarting syscall at the last hunk.

Thanks.

SUGIOKA Toshinobu

