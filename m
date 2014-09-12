From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Sep 2014 08:08:12 +0000
Subject: Re: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
Message-Id: <CAMuHMdWHDks85oFdE1zhRBFxoVdQuU0XCT0vFkdJwTxK-0w9QQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <1591383.Xdy91rktuP@fb07-iapwap2> <20140911145421.GE5149@katana>
 <9935938.eKOCvCAtLt@fb07-iapwap2>
In-Reply-To: <9935938.eKOCvCAtLt@fb07-iapwap2>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Marc,

On Fri, Sep 12, 2014 at 9:51 AM, Marc Dietrich <marvin24@gmx.de> wrote:
> Am Donnerstag, 11. September 2014, 16:54:22 schrieb Wolfram Sang:
>> On Thu, Sep 11, 2014 at 04:52:22PM +0200, Marc Dietrich wrote:
>> > Am Donnerstag, 11. September 2014, 16:40:04 schrieb Wolfram Sang:
>> > > > b) could be seen as a configuration thing since the functionality
>> > > > backend could be changed at runtime even.
>> > >
>> > > Come to think of it, not only the functionality, also the address ca=
n be
>> > > changed at runtime. This makes me think it should really not be in DT
>> > > after all.
>> >
>> > even worse, there can be multiple masters and slaves changing their ro=
le
>> > on
>> > the fly AFAIK. So the best dt can do is to provide an initial
>> > configuration, so all drivers know where they are and where to start.
>> > Everything else can be changed during runtime.
>>
>> Why do you want DT to be involved at all?
>
> Imagine a device which supports both, slave or master mode. The driver ne=
eds
> to know in which mode it should operate. This cannot be hard coded, becau=
se on
> different boards, different modes can be used.
>
> The point is, that if we define a dt binding for master device on slave
> adapters it will be there forever. So even if it makes no sense for the
> example eeprom simulator (or even our embedded controller), it may make s=
ense
> for other or future devices.

DT describes the hardware. The most you can do is describe an i2c
adapter, and an i2c bus with (physical) i2c slaves, if any, and (other)
i2c masters[*], if any.

If the description contains i2c slaves, the i2c adapter can operate in
(but may be not limited to) master mode.

I2c slaves implemented in Linux are not physical i2c slaves, but just
a piece of software. They can appear/disappear/change at any time.
Hence I think this is something to be configured by userspace, like
"tie the i2c-eeprom-slave driver to address 64 on i2c bus 3".

And then you can have the mixed case, where the i2c adapter is both
a master, talking to the physical slaves, and a slave, being talked to by
another master. But that's just a superposition of the two cases above,
right?

[*] Are there bindings for other masters on an i2c bus?

Just my 0.02=E2=82=AC (as long as those coins still exist).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
