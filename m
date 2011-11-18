From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 18 Nov 2011 09:10:29 +0000
Subject: Re: [PATCH 0/3 v2] Switch sh7722, sh7723, and sh7724 to a generic
Message-Id: <CANqRtoR7HoEF3cObfT66SS19k2XWBibZUjYqwWhzgY=5tD=ikQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1111171446150.2650@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1111171446150.2650@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 18, 2011 at 4:34 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Thu, Nov 17, 2011 at 02:55:42PM +0100, Guennadi Liakhovetski wrote:
>> The sh/pm-runtime branch of https://github.com/pmundt/linux-sh begins the
>> migration of SuperH platforms from their hwblk runtime PM implementation
>> to the common with ARM-based sh-mobile platforms code. These patches
>> actually migrate sh7722, sh7723, and sh7724 architectures over.
>>
>> v2 is functionally identical to v1, it only removes the MSTP() wrapper, as
>> requested by Paul.
>>
> I've layered hwblk removal on top of this, in the sh/hwblk topic branch.

Thanks for your help, Paul!

> I expect cpuidle is probably going to be broken until it gets some clue
> about powerdomains, though.

On SH there is no power domain control via cpuidle, so it should be OK as-is.

Cheers,

/ magnus
