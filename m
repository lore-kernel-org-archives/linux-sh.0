From: Rob Landley <rob@landley.net>
Date: Sat, 18 Feb 2017 07:13:05 +0000
Subject: Re: [PATCH 0/1] Documentation: convert sh interfaces to RST
Message-Id: <cb72d2e4-0329-c11b-06e2-00889403b290@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1484863602-27393-1-git-send-email-steven@wedontsleep.org>
In-Reply-To: <1484863602-27393-1-git-send-email-steven@wedontsleep.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org



On 02/12/2017 05:35 PM, Jonathan Corbet wrote:
> On Fri, 20 Jan 2017 09:06:41 +1100
> Steve Kowalik <steven@wedontsleep.org> wrote:
> 
>> The following patch converts the SuperH interfaces DocBook into RST,
>> however, I've not added it to the toctree, since I'm not 100% clear
>> where it best fits.
> 
> So I have to apologize, this fell through the cracks in the disaster that
> is my inbox.
> 
> The conversion itself looks mostly OK.  There is, however, a copyright
> assertion in the original template file that should really be preserved
> in the new file as well; usually I put those in as comments at the top of
> the RST file.
> 
> As for where it fits; it seems maybe we need a subbook for
> architecture-specific stuff.  Documentation/arch or /arch-guide?

Documentation/arch mirrors the kernel source layout, and I actually
submitted patches to collate the various arch directories under that
many moons ago. You may remember:

  https://lwn.net/Articles/244448/

> Thanks,
> 
> jon

Rob
