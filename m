From: Rob Landley <rob@landley.net>
Date: Mon, 15 May 2017 18:17:22 +0000
Subject: Re: QEMU serial still broken in -rc1.
Message-Id: <93cfad25-187a-3a19-604c-fe4b99b9e87d@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cdec4797-afe1-11f8-f926-fb5d356da625@landley.net>
In-Reply-To: <cdec4797-afe1-11f8-f926-fb5d356da625@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On 05/15/2017 12:13 AM, John Paul Adrian Glaubitz wrote:
> On 05/15/2017 07:11 AM, John Paul Adrian Glaubitz wrote:
>> They do fix bugs but they often take some time to work through the
>> patch queue because they usually get a larger number of patches [1].
> 
> Oh, and Aurelien Jarno has pushed a larger number of SH-related fixes [1].

My attempts to re-test hit:

cd ~/qemu/qemu && git clean -fdx && git checkout -f && git pull &&
./configure && make
...
  CC      hw/core/loader-fit.o
hw/core/loader-fit.c: In function ‘fit_image_addr’:
hw/core/loader-fit.c:105:32: error: ‘fdt32_t’ undeclared (first use in
this function)
         *addr = fdt32_to_cpu(*(fdt32_t *)prop);

I'll let you know if it fixes anything when the tree starts building again.

Thanks,

Rob
