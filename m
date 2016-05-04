From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 04 May 2016 06:41:18 +0000
Subject: Re: [PATCH RESEND 05/12] sh: DeviceTree support update
Message-Id: <CAMuHMdUAGXLeiAh1tRDabKOXSRPM4UYyHO4Tz65bof8uBGz0zQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1462079316-27771-1-git-send-email-ysato@users.sourceforge.jp>
	<1462079316-27771-6-git-send-email-ysato@users.sourceforge.jp>
	<20160504031005.GO21636@brightrain.aerifal.cx>
In-Reply-To: <20160504031005.GO21636@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, May 4, 2016 at 5:10 AM, Rich Felker <dalias@libc.org> wrote:
>On Sun, May 01, 2016 at 02:08:29PM +0900, Yoshinori Sato wrote:
>>  static void __init sh_of_setup(char **cmdline_p)
>>  {
>> -     unflatten_device_tree();
>> -
>> -     board_time_init = sh_of_time_init;
>> +     struct device_node *cpu;
>> +     int freq;

You better make freq unsigned.

>>       sh_mv.mv_name = of_flat_dt_get_machine_name();
>>       if (!sh_mv.mv_name)
>>               sh_mv.mv_name = "Unknown SH model";
>>
>>       sh_of_smp_probe();
>> +     cpu = of_find_node_by_name(NULL, "cpu");
>> +     if (!of_property_read_u32(cpu, "clock-frequency", &freq))
>> +             preset_lpj = freq / 500;
>>  }
>
> I setup the DT-based pseudo-board to use the generic calibrate-delay
> rather than hard-coding lpj. Ideally we could just get rid of bogomips
> completely but there are probably still some things using it. Is there
> a reason you prefer making up a value for lpj based on the cpu clock
> rate?

Calibrating the delay loop takes some time.
However, you shouldn't hardcode 500, but take HZ into account.
I assume you used the default HZ%0, so

        preset_lpj = freq / HZ / 2;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
