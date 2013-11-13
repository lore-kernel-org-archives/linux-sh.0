From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 13 Nov 2013 10:24:51 +0000
Subject: Re: rcar-h2 du issue between du0 and du2
Message-Id: <52835373.8000907@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <52825196.1090102@codethink.co.uk>
In-Reply-To: <52825196.1090102@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 13/11/13 02:44, Laurent Pinchart wrote:
> Hi Ben,
>
> On Tuesday 12 November 2013 16:04:38 Ben Dooks wrote:
>> I am using the 3.4 renesas backport (0.5.1) and having issue with the
>> rcar_du driver with any du0 and du2 having seperate operating modes.
>>
>> du2 seems to be picking up the data width of du0, so if du0 is at
>> 1920x1080 and du2 at 800x600, du2 will show a display as if du2 data
>> was at a 1920 stride.
>>
>> If both du0 and du2 are at 800x600 then both show the right display
>> data,
>
> Ouch. Thank you for the report. I'll test and debug that. What's the urgency
> level ?

Medium, there's other stuff that I can be getting on with.

I've been looking through the H2 manual but there's nothing specifically
saying the DU0 and DU2 planes should be linked. I know DU0_0 and DU0_1
are basically linked.

We are using the Lager board as following:

We have DU0 outputting LVDS to the ADV7511 to provide DVI
DU2 is connected to the DPAD0 to the VGA

DU0 is configured for 1920x1080-60, 32bpp
DU2 is configured for 800x600-60, 32bpp

DU2 has been verified as outputting 800x600-60 display timings.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
