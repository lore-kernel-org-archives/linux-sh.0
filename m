From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Mon, 12 Jan 2009 03:48:02 +0000
Subject: Re: [Qemu-devel] [PATCH 1/3] sh: SE7750 board definition
Message-Id: <496ABD72.20400@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <4969B77E.7050206@juno.dti.ne.jp>
	<20090111130445.GA12080@game.jcrosoft.org>
In-Reply-To: <20090111130445.GA12080@game.jcrosoft.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>, qemu-devel@nongnu.org
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Thank you for the review!
# This mail CCed to linux-sh ML expecting some comments on SE7750 flash.

Jean-Christophe PLAGNIOL-VILLARD wrote:
>> +#define SDRAM_BASE   0x0c000000 /* Physical location of SDRAM: Area 3 */
>> +#define SDRAM_SIZE   0x02000000
> 
>> +#define ENTRY_OFFSET 0x00001000
>> +#define COMMAND_LINE_OFFSET 0x0000100
> IIRC it's the case for all SH4 maybe we could define it in a header and all
> board to overwrite it
I agree.  I think it will be another patch.

>> +
>> +static void se7750_init(ram_addr_t ram_size, int vga_ram_size,
>> +                    const char *boot_device, DisplayState * ds,
>> +                    const char *kernel_filename, const char *kernel_cmdline,
>> +                    const char *initrd_filename, const char *cpu_model)
>> +{
>> +    CPUState *env;
>> +    struct SH7750State *s;
>> +    ram_addr_t sdram_addr;
>> +    int kernel_size;
>> +    uint8 * phys_load_addr = phys_ram_base;
>> +
>> +    /* initialize CPU */
>> +    if (!cpu_model)
>> +        cpu_model = "SH7750";
>> +
>> +    env = cpu_init(cpu_model);
>> +    if (!env) {
>> +        fprintf(stderr, "Unable to find CPU definition\n");
>> +        exit(1);
>> +    }
>> +
>> +    /* Allocate memory space */
>> +    sdram_addr = qemu_ram_alloc(SDRAM_SIZE);
>> +    cpu_register_physical_memory(SDRAM_BASE, SDRAM_SIZE, sdram_addr);
>> +
>> +    /* Register peripherals */
>> +    s = sh7750_init(env);
>> +
>> +    /* initialization which should be done by firmware */
>> +    uint32_t bcr1 = 1 << 3; /* cs3 SDRAM */
>> +    uint16_t bcr2 = 3 << (3 * 2); /* cs3 32-bit */
> please move tihs too the beginning of the function
Sure. I'll do so.

>> +    cpu_physical_memory_write(SH7750_BCR1_A7, (uint8_t *)&bcr1, 4);
>> +    cpu_physical_memory_write(SH7750_BCR2_A7, (uint8_t *)&bcr2, 2);
>> +
>> +    /* Start from P2 area */
>> +    env->pc = SDRAM_BASE | 0xa0000000;
>> +
>> +    /* pass kernel cmdline */
>> +    if (kernel_cmdline) {
>> +        pstrcpy((char *)phys_load_addr + ENTRY_OFFSET + COMMAND_LINE_OFFSET,
>> +                strlen(kernel_cmdline) + 1, kernel_cmdline);
>> +        env->pc += 0x80000;
>> +        phys_load_addr += 0x80000;
>> +    }
> do you known the flash model present on the real board?
No, I don't.
The patches for SE7750 are all implemented using informations in linux source code.
I visited Solution Engine site (in Japanese) but could not find useful specs.
http://www.hitachi-ul.co.jp/system/SH-SE/shiyou.html

Regards,
Shin-ichiro KAWASAKI
