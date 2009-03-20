From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 20 Mar 2009 10:01:53 +0000
Subject: Re: [PATCH] sh: disallow kexec virtual entry
Message-Id: <20090320100153.GA13269@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090319100429.9817.21412.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090319100429.9817.21412.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 19, 2009 at 07:04:29PM +0900, Magnus Damm wrote:
> Older versions of kexec-tools has a zImage loader that
> passes a virtual address as entry point. The elf loader
> otoh it passes a physical address as entry point, and
> pages are always passed as physical addresses as well.
> 
> Only allow physical addresses from now on.

On Thu, Mar 19, 2009 at 07:05:58PM +0900, Magnus Damm wrote:
> This patch modifies the SuperH RTC driver to only
> enable carry interrupts when needed. So by default
> no interrupts are enabled with this patch. Without
> this patch a suspending system will most likely
> wake up by the carry interrupt regardless if the
> alarm interrupt has been enabled or not.

On Thu, Mar 19, 2009 at 07:10:44PM +0900, Magnus Damm wrote:
> This patch modifies invalid time handling in the
> SuperH RTC driver. Instead of zeroing the returned
> value at read-out time we just return an error code
> and reset invalid values during probe.

On Thu, Mar 19, 2009 at 07:14:41PM +0900, Magnus Damm wrote:
> Flag that the SuperH RTC supports wakeup.

Applied, thanks.
