From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 06 Nov 2009 02:37:32 +0000
Subject: Re: [PATCH 02/05] Driver Core: Early platform driver buffer
Message-Id: <aec7e5c30911051837q3c45e330h8cc427b6eb8a4905@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091105143508.9902.22192.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091105143508.9902.22192.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, Nov 6, 2009 at 10:33 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Thu, Nov 05, 2009 at 11:35:08PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Add early_platform_init_buffer() support and update the
>> early platform driver code to allow passing parameters
>> to the driver on the kernel command line.
>>
>> early_platform_init_buffer() simply allows early platform
>> drivers to provide a pointer and length to a memory area
>> where the remaining part of the kernel command line option
>> will be stored.
>>
>> Needed to pass baud rate and other serial port options
>> to the reworked early serial console code on SuperH.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> ---
>>
>> =A0drivers/base/platform.c =A0 =A0 =A0 =A0 | =A0 29 ++++++++++++++++++++=
++-------
>> =A0include/linux/platform_device.h | =A0 20 +++++++++++++++-----
>> =A02 files changed, 37 insertions(+), 12 deletions(-)
>>
> This needs to be run by Greg and acked before anything can be done with
> the rest of this series.

Right, but you're not opposed to breaking out the serial ports then?
Last version didn't support setting baud rate over the kernel command
line among other things, but those issues should all be addressed in
this version.

Cheers,

/ magnus
