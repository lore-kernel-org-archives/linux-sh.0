From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 15 Dec 2012 07:29:32 +0000
Subject: Re: [PATCH 4/7] ARM: sh7372: add clock lookup entries for DT-based devices
Message-Id: <20121215072932.3DC0B3E0C0F@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
 <1355503531-7276-5-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1355503531-7276-5-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 14 Dec 2012 17:45:28 +0100, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> When booting with DT, devices are named differently. To get their clocks
> additional entries have to be added to the lookup table.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Please use AUXDATA to manipulate the device name for consistency with
other platforms. When clock bindings get added to the device tree for
this platform then all the AUXDATA declarations can be removed.

g.

