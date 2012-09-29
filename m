From: Bastian Hecht <hechtb@googlemail.com>
Date: Sat, 29 Sep 2012 11:54:08 +0000
Subject: Re: [PATCH v2 1/2] mtd: sh_flctl: Setup and release DMA channels
Message-Id: <CABYn4szzM-UeBxjEr7Hs62ohAGFpOBVhG0np=jbAWh6W6xLF0A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1348478315-10789-1-git-send-email-hechtb@gmail.com>
 <Pine.LNX.4.64.1209271656020.7862@axis700.grange>
 <CABYn4sw6uXtA7V-goLGv3H7AZ1zbWLAHZqGd+5w9eB_e8yua9w@mail.gmail.com>
 <Pine.LNX.4.64.1209281152130.5428@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1209281152130.5428@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Vikram Narayanan <vikram186@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

2012/9/28 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> On Fri, 28 Sep 2012, Bastian Hecht wrote:
>
> [snip]
>
>> Oh yes, I'll add <linux/completion.h>.
>> About the forward declration: Do I really need it? We use a struct
>> pointer and I am unsure if the compiler just needs to know the name
>> and nothing more. I've tested it and included sh_flctl.h (without any
>> DMA headers) in some driver that has no idea about DMA.
>> gcc didn't complain.
>
> I'm not sure about this, I think, sometimes there might be cases, when gcc
> doesn't complain. Or (more likely) the header is pulled in via another
> one, or some other header has this forward-declaration. But in any case I
> wouldn't rely on either of those and declare what's needed explicitly.
>
>> Adding a non-pointer member
>> + struct sh_dma test;
>> lead to an error, so struct sh_dma is really unknown.
>
> Of course, the compiler has to know the size of the struct to allocate
> space for it:-)
>

Ah sure - I thought I catch any header pull-ins by this test but yeah
- it can be just forward declarations too...

So I will post a merged v3 under the new title: "mtd: sh_flctl: Add
DMA capabilty".
It includes the critics from here plus 2 other things:
 - "Fall back to PIO" now actually falls back for the current read
operation and not just for future reads
 - I removed the init_completion() after each DMA read. The completion
gets set up at probe time and what I read on the internet and in
researched in the sources we don't need to reset it then after each
usage.

thanks,

 Bastian
