From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 08 Feb 2010 02:09:24 +0000
Subject: Re: [GIT PULL] DWARF unwinder updates for 2.6.34
Message-Id: <20100208020924.GA6839@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <m3bpg0onq1.fsf@phlog.console-pimps.org>
In-Reply-To: <m3bpg0onq1.fsf@phlog.console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Feb 07, 2010 at 07:22:14PM +0000, Matt Fleming wrote:
> I've got a bunch of DWARF unwinder patches in my tree. There are 3 bug
> fixes but I'm guessing -rc7 is too late in the game for applying them?

They look reasonable for 2.6.33, so I've cherry-picked the bugfixes
there. I'll roll the rbtree patch in on top of those for 2.6.34.

> I'm assuming that they will fix the issues you were seeing on qemu but I
> haven't been able to test qemu recently so I'm not sure.
> 
I'll test it out later today, thanks.
