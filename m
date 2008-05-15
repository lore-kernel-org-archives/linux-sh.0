From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 15 May 2008 04:26:28 +0000
Subject: Re: fix entry-common.S
Message-Id: <20080515042628.GA2260@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080514.110900.125129265.saito@densan.co.jp>
In-Reply-To: <20080514.110900.125129265.saito@densan.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 14, 2008 at 11:09:00AM +0900, Hideo Saito wrote:
> In the code on entry-common.S, it seems that the following fix is
> needed, because the code causes to jump to |resume_userspace| from
> |syscall_badsys| without set r8.
> 
That's true for the syscall_badsys path, but not for any of the other
resume_userspace callees. The comment at the beginning of
resume_userspace indicates that we expect r8 to be set by the caller,
which looks like it got trampled in the syscall_badsys case. So, I've
moved the r8 assignment in to the syscall_badsys path instead.

Good catch, thanks!
