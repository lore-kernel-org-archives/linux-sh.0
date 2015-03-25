From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Wed, 25 Mar 2015 01:14:54 +0000
Subject: Re: Can't mount QSPI-FLASH to userland on Lager
Message-Id: <55120C0E.1000703@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <550F6E10.8010907@jinso.co.jp>
In-Reply-To: <550F6E10.8010907@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi Mark-san

Thanks for your comments,

On 2015年03月25日 01:24, Mark Brown wrote:
> On Tue, Mar 24, 2015 at 04:17:32PM +0900, Cao Minh Hiep wrote:
>> On 2015年03月24日 01:27, Mark Brown wrote:
>>> Interesting...  nobody else has reported any problems.  Can you collect
>>> traces from the failing and successful systems with ftrace (turn on
>>> /sys/kernel/debug/tracing/events/spi/enable to get all the SPI logging)
>>> please?
>> I attached the traces logs file of failing and successful systems:
>> file1: qspi_v4.0-rc2_added_tracer_test_logs_lager.txt
>> file2: qspi_v4.0-rc2_added_tracer_and_reverting_patches_test_logs_lager.txt
>> And also attached the logs file of 10times for testing in before/after
>> reverting patches without tracer.
>> file3: qspi_v4.0-rc2_test_logs_for_10times_lager.txt
>> file4: qspi_v4.0-rc2_after_reverting_patches_test_logs_for_10times_lager.txt
> These all look like console logs, not ftrace logs?
The file3 and file4 are logs of normal 10times test which enabled ext3, 
ext4 in configuration.

The file1 and file2 are logs after enabling Kernel Function Tracer and 
Trace syscalls
...debug/tracing/events/spi/enable is not showed in default config.
Could you please tell me the correct way to get ftrace logs?

Thank you!
Hiep.

