From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 31 Jul 2013 19:39:30 +0000
Subject: Re: [PATCH] ARM: Fix memblock_reserve() to include stext
Message-Id: <20130731193930.GY24642@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20130731055807.14054.70106.sendpatchset@w520>
 <20130731094352.GV24642@n2100.arm.linux.org.uk>
 <CANqRtoR5j2VyRwf0suABfVLxzU30pZndEcCj7uZ2sSrzfGmx_A@mail.gmail.com>
In-Reply-To: <CANqRtoR5j2VyRwf0suABfVLxzU30pZndEcCj7uZ2sSrzfGmx_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 01, 2013 at 04:34:03AM +0900, Magnus Damm wrote:
> Are you aware of any existing fix for this or anyone working on
> solving this issue? If not then I don't mind stepping up. I can
> however think of quite a few other things to do if this has been
> solved already though, so please let me know if you think I should
> focus on fixing this.

I committed a fix for it this morning, so it should be in linux-next by
tomorrow.

