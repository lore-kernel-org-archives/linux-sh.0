From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Dec 2015 09:22:06 +0000
Subject: Re: [PATCH 00/04] ARM: shmobile: IPMMU compat string SoC part number update
Message-Id: <CANqRtoQN-R-1i945eapafSQO1Y1HwR0TDvtMycgu8UXY_kFhOg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151117043047.4521.84234.sendpatchset@little-apple>
In-Reply-To: <20151117043047.4521.84234.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Tue, Dec 15, 2015 at 6:17 PM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Nov 24, 2015 at 11:45:41AM +0900, Simon Horman wrote:
>> On Tue, Nov 17, 2015 at 01:30:47PM +0900, Magnus Damm wrote:
>> > ARM: shmobile: IPMMU compat string SoC part number update
>> >
>> > [PATCH 01/04] ARM: shmobile: r8a7790: IPMMU compat string SoC part number update
>> > [PATCH 02/04] ARM: shmobile: r8a7791: IPMMU compat string SoC part number update
>> > [PATCH 03/04] ARM: shmobile: r8a7793: IPMMU compat string SoC part number update
>> > [PATCH 04/04] ARM: shmobile: r8a7794: IPMMU compat string SoC part number update
>> >
>> > Update R-Car Gen2 DT compat strings for IPMMU devices to follow the updated
>> > DT binding documentation included in:
>> > "[PATCH v2] iommu/ipmmu-vmsa: Include SoC part number in DT binding docs"
>> >
>> > With this compat string change we may in the future add SoC-specific features
>> > such as IPMMU performance counters that only exist on some SoCs.
>> >
>> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>>
>> I have marked these patches as deferred pending the binding changes being
>> accepted. Please repost or otherwise ping me once that has happened.
>
> As discussed elsewhere, the bindings have been accepted.
> I have queued up these patches accordingly.

Thanks for your help!!

/ magnus
