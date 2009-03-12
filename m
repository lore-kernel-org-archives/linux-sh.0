From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 12 Mar 2009 02:23:39 +0000
Subject: Re: [PATCH 00/09] sh: clean up pci code
Message-Id: <aec7e5c30903111923q48b6a4d9mcc3a58e2891b3c05@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080219123420.4266.2965.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080219123420.4266.2965.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 11, 2009 at 5:31 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Feb 19, 2008 at 09:34:20PM +0900, Magnus Damm wrote:
>> These patches rework the pci code for the sh architecture.
>>
>> Currently each board implements some kind of ioport to address mapping. Some
>> boards use generic_io_base others try passing addresses as io ports. This is
>> the first set of patches that try to unify the pci code as much as possible
>> to avoid duplicated code. This will in the end lead to fewer lines board
>> specific code and more generic code.
>>
>> Only high level stuff so far. These patches avoid changing low level bits,
>> I have patches for sh7751 and sh7780 doing that already. I'll post then
>> later on this week after some more testing.
>>
>> Have fun and people with pci host controllers - please test!
>>
> I've merged this series in to the sh/pci-rework topic branch. It needs
> some more work, some of which I've already done, but it makes more sense
> to concentrate development in one place and merge it when it's ready.

Thanks. Let me know if there is any specific pci task you want me to
focus on. I mainly remembering a lot of board-specific code that would
be difficult to test without access to hardware.

Cheers,

/ magnus
