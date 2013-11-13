From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 13 Nov 2013 02:44:07 +0000
Subject: Re: rcar-h2 du issue between du0 and du2
Message-Id: <6755210.ZROkdKfUgf@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <52825196.1090102@codethink.co.uk>
In-Reply-To: <52825196.1090102@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Tuesday 12 November 2013 16:04:38 Ben Dooks wrote:
> I am using the 3.4 renesas backport (0.5.1) and having issue with the
> rcar_du driver with any du0 and du2 having seperate operating modes.
> 
> du2 seems to be picking up the data width of du0, so if du0 is at
> 1920x1080 and du2 at 800x600, du2 will show a display as if du2 data
> was at a 1920 stride.
> 
> If both du0 and du2 are at 800x600 then both show the right display
> data,

Ouch. Thank you for the report. I'll test and debug that. What's the urgency 
level ?

-- 
Regards,

Laurent Pinchart

