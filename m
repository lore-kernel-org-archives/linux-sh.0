From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 13 Jan 2012 09:45:52 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: fix A3SP suspend method
Message-Id: <CANqRtoRYaogeL=soJY3PjoDcw1qXi-b1UGG3zHzCS9wGLeYybQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201201130048.09751.rjw@sisk.pl>
In-Reply-To: <201201130048.09751.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, Jan 13, 2012 at 8:48 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, January 12, 2012, Guennadi Liakhovetski wrote:
>> Fix the reverted condition in sh7372_a3sp_suspend().
>>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> ---
>> diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile=
/pm-sh7372.c
>> index 77b8fc1..43baa97 100644
>> --- a/arch/arm/mach-shmobile/pm-sh7372.c
>> +++ b/arch/arm/mach-shmobile/pm-sh7372.c
>> @@ -276,7 +276,7 @@ static int sh7372_a3sp_suspend(void)
>> =A0 =A0 =A0 =A0* Serial consoles make use of SCIF hardware located in A3=
SP,
>> =A0 =A0 =A0 =A0* keep such power domain on if "no_console_suspend" is se=
t.
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 return console_suspend_enabled ? -EBUSY : 0;
>> + =A0 =A0 return console_suspend_enabled ? 0 : -EBUSY;
>> =A0}
>>
>> =A0struct sh7372_pm_domain sh7372_a3sp =3D {
>
> Magnus, the patch is correct, but I need your ACK here.

Yes, it indeed seems like a correct fix.

Acked-by: Magnus Damm <damm@opensource.se>

Thanks to you and Guennadi for fixing this.

Cheers,

/ magnus
