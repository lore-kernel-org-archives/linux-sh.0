From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 16 Jul 2015 16:12:19 +0000
Subject: Re: [PATCH 2/2] ARM: xip: Use correct symbol for end of ROM marker
Message-Id: <20150716161219.GL7557@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1437057434-1616-1-git-send-email-chris.brandt@renesas.com>
 <1437057434-1616-3-git-send-email-chris.brandt@renesas.com>
In-Reply-To: <1437057434-1616-3-git-send-email-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jul 16, 2015 at 10:37:14AM -0400, Chris Brandt wrote:
> For an XIP build, _edata_loc, not _etext, is the end of constant R/O
> memory that needs to be mapped into the MODULES_VADDR area. This fixes
> the bug where you might loose part of your R/O data after page table
> setup is complete.

That's not correct.  _etext is set in the linker script to be the end of
the text + readonly data + exception table + unwinder tables + notes.
_edata_loc is the end address of the read/write data section stored in
read-only memory, which exists to be copied by the early kernel assembly
code to RAM.  There's no need for that to remain mapped.

I think you need to either provide more details of the problem you're
seeing, or further reasoning why this is a correct change.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
