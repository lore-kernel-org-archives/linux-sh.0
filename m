From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 14 Nov 2013 12:52:06 +0000
Subject: Re: rcar-h2 du issue between du0 and du2
Message-Id: <5284C776.2050001@codethink.co.uk>
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

I've found the issue, it was with a change we did to the kernel to split
the displays and accidentally sent the same block of memory to both du 
units. Sorry for the inconvenience, it is working now.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
