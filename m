From: Rob Landley <rob@landley.net>
Date: Tue, 29 Mar 2016 04:17:16 +0000
Subject: Re: Availability of SH hardware?
Message-Id: <56FA01CC.7040602@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317032441.GA22517@brightrain.aerifal.cx>
In-Reply-To: <20160317032441.GA22517@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 03/26/2016 04:37 PM, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 03/26/2016 10:18 PM, Zoltan HERPAI wrote:
>> I bought an SH3 (T-SHMIN) and an SH4 (USL-5P, which resembles a Landisk
>> but with a couple USB ports instead of an ATA port) board with the help
>> of Nobuhiro-san a couple years ago, for helping my intention of building
>> an OpenWrt target for sh3 and sh4. These could also be a good target to
>> acquire, although I'm not aware of the current pricetags.
> 
> I'm constantly checking Yahoo Auction Japan, but so far I have seen only
> SH-2A and SH-4 or SH-4A hardware only.
> 
>> If someone would help to acquire multiple pieces of any SH4 board, I'd
>> also like to jump on the bandwagon - that would likely push me to finish
>> the target and commit it. :)
> 
> My plan is to buy as many of these NextVoD devices from Taiwan and then
> send them out to anyone willing to do SuperH kernel or userland
> development, so I'd be happy to send you one.
> 
> At a 10-15 USD price tag those are very affordable.
> 
> Adrian

I note that if anybody wants to play with a j-core board, the easy way
is to grab a $50 Numato Mimas v2 FPGA board from
http://numato.com/mimas-v2-spartan-6-fpga-development-board-with-ddr-sdram/
and follow the instructions on http://nommu.org/jcore (which are a few
months old but should still work).

I'm trying to get that web page completely rewritten and moved to its
own domain and the repository converted from mercurial to git and up on
github by ELC in San Diego next week. If you're going there, we should
be raffling off a dozen of the Numato boards, along with the micro-SD
card and USB "mini-B" cable each one needs to funciton, which is only
like $5 more hardware but is not included with the board.

Jeff Dionne (founder of uClinux way back when, and now maintainer of the
j-core project) is giving two talks at ELC, one on why we're doing it
and one a design walkthrough of the open source VHDL code (aimed at
software developers who've never done hardware before but might want to
learn a new programming language to poke at a project they can test at
home).

Rob
