From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 23 May 2011 06:51:20 +0000
Subject: Re: [PATCH 0/6 v2] MERAM support for LCDC
Message-Id: <20110523065120.GJ5206@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1305717011-20742-1-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1305717011-20742-1-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 18, 2011 at 08:10:05PM +0900, Damian Hobson-Garcia wrote:
> This patch series adds support for read-ahead cache-access from the 
> LCDC to the main memory.  These patches enabled the LCDC to access
> the MERAM memory via ICB.  The specific ICBs to use are chip dependent
> and defined in the platform data.
> 
> The MERAM clock will enable when the LCDC clocks do, and are allowed to 
> be disbled when the LCDC clocks are.
> 
> Changes from V1
> ---------------
> * Specified meram info data (struct sh_mobile_meram_info *meram_dev) as
>   part of the LCDC device data, not the LCDC channel data, since the info
>   data corresponds to the whole device, not just one configuration.
> 
> * Added dynamic clock enable/disable via runtime_pm.
> 
> * Changed .id from -1 to 0 in platform data
> 
> Damian Hobson-Garcia (6):
>   sh_mobile: Add MSTP clock for MERAM
>   sh_mobile_meram: MERAM framework for LCDC
>   sh_mobile_meram: Add support for NV24 framebuffers

These basically seem to be fine, and make up for the bulk of the new
code, so I'll take them as-is. I'll let you and Magnus hash out the
remaining bits after this.
