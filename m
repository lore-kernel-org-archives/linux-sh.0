From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 03 May 2011 13:57:42 +0000
Subject: Re: Resend [PATCH 00/10] ARM: SMP initialization consolidation
Message-Id: <201105031557.42355.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
	<4DBBA509.6080203@codeaurora.org>
	<20110502234012.GJ28001@n2100.arm.linux.org.uk>
In-Reply-To: <20110502234012.GJ28001@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 03 May 2011, Russell King - ARM Linux wrote:
> Such a SoC may wish to do things differently from the current approach
> (which is basically bring up all cores at boot) particularly as the
> performance gained from each CPU is far from identical.  So I've been
> nervous about moving the CPU map initialization into core code.
> 
> Note that the low power CPU may not be the last in the set, so merely
> limiting the system to two CPUs is not the answer.

If I read the patches correctly, it's still strictly opt-in per platform.
When a platform wants to support the setup you mentioned or something
even stranger, all it would have to do is provide its own versions of
the SMP pen and scu init function, right?

	Arnd
