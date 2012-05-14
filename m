From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 14 May 2012 12:30:34 +0000
Subject: Re: [PATCH 03/03] ARM: Undelete KZM9D mach-type
Message-Id: <20120514123034.GD10453@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20120514105424.8596.38355.sendpatchset@w520>
 <20120514105451.8596.92367.sendpatchset@w520>
In-Reply-To: <20120514105451.8596.92367.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, May 14, 2012 at 07:54:51PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Undelete the KZM9D mach-type to allow build of board
> for EMEV2 SoC support.

If you've converted to use DT for KZM9D, do you still need this?
