From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Apr 2013 22:27:41 +0000
Subject: Re: [PATCH] ARM: shmobile: Include all 2 GiB of memory on APE6EVM
Message-Id: <CANqRtoTCYVY9Q6-2wUshSxZzXNsUx4xdY+phf2ZyHmwSyj4SRw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130408014444.18767.64441.sendpatchset@w520>
 <20130409123433.GD15412@verge.net.au>
 <20130409161410.GA16003@verge.net.au>
In-Reply-To: <20130409161410.GA16003@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Wed, Apr 10, 2013 at 1:14 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Apr 09, 2013 at 09:34:34PM +0900, Simon Horman wrote:
>> On Mon, Apr 08, 2013 at 10:44:44AM +0900, Magnus Damm wrote:
>> > From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
>> >
>> > Add 1GiB of DRAM at 0x2_0000_0000
>> >
>> > Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
>> > Signed-off-by: Magnus Damm <damm@opensource.se>
>>
>> Thanks, queued up in the boards-ape6evm branch.
>
> I have dropped this patch as it appears to prevent
> the board from booting.

Is it possible that LPAE=n and HIGHMEM=y in your particular kernel
configuration?

From what I can tell HIGHMEM is broken in cases of large amounts of
memory. Try disabling that as a short-term workaround. Then of course
someone needs to track down why the generic code doesn't work as
expected.

Thanks,

/ magnus
