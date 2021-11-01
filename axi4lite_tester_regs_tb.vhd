-- -----------------------------------------------------------------------------
-- Testbench for the 'axi4lite_tester' Register Component
-- Revision: 0
-- -----------------------------------------------------------------------------
-- Generated on 2021-10-04 at 10:51 (UTC) by airhdl version 2021.09.1
-- -----------------------------------------------------------------------------
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-- IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
-- ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
-- -----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.textio.all;
use work.axi4lite_tester_regs_pkg.all;

library uvvm_util;
context uvvm_util.uvvm_util_context;

library bitvis_vip_axilite;
use bitvis_vip_axilite.axilite_bfm_pkg.all;

entity axi4lite_tester_regs_tb is
  generic (
    AXI_ADDR_WIDTH : integer := 32 -- width of the AXI address bus
  );
end entity axi4lite_tester_regs_tb;

architecture test of axi4lite_tester_regs_tb is

  -- Wait for a given number of clock cycles
  procedure waitclk(signal clk : in std_logic; cycles : natural) is
  begin
    for i in 1 to cycles loop
      wait until rising_edge(clk);
    end loop;
  end procedure;

  -- Print a message on the console
  procedure print(message : string) is
    variable v_line : line;
  begin
    write(v_line, message);
    writeline(output, v_line);
  end procedure;

  -- Types
  type mem_t is array (natural range <>) of std_logic_vector(31 downto 0);

  -- Constants
  constant AXI_OKAY : std_logic_vector(1 downto 0) := "00";

  -- Signals
  signal axi_aclk : std_logic := '0';
  signal axi_aresetn : std_logic;
  signal axi_awaddr : std_logic_vector(AXI_ADDR_WIDTH - 1 downto 0);
  signal axi_awprot : std_logic_vector(2 downto 0);
  signal axi_awvalid : std_logic;
  signal axi_awready : std_logic;
  signal axi_wdata : std_logic_vector(31 downto 0);
  signal axi_wstrb : std_logic_vector(3 downto 0);
  signal axi_wvalid : std_logic;
  signal axi_wready : std_logic;
  signal axi_araddr : std_logic_vector(AXI_ADDR_WIDTH - 1 downto 0);
  signal axi_arprot : std_logic_vector(2 downto 0);
  signal axi_arvalid : std_logic;
  signal axi_arready : std_logic;
  signal axi_rdata : std_logic_vector(31 downto 0);
  signal axi_rresp : std_logic_vector(1 downto 0);
  signal axi_rvalid : std_logic;
  signal axi_rready : std_logic;
  signal axi_bresp : std_logic_vector(1 downto 0);
  signal axi_bvalid : std_logic;
  signal axi_bready : std_logic;
  signal user2regs : user2regs_t;
  signal regs2user : regs2user_t;

  constant clk_period : time := 5 ns; -- 100 MHz

  subtype ST_AXILite_32 is t_axilite_if (
  write_address_channel (
  awaddr(AXI_ADDR_WIDTH - 1 downto 0)),
  write_data_channel (
  wdata(AXI_ADDR_WIDTH - 1 downto 0),
  wstrb(3 downto 0)),
  read_address_channel (
  araddr(AXI_ADDR_WIDTH - 1 downto 0)),
  read_data_channel (
  rdata(AXI_ADDR_WIDTH - 1 downto 0))
  );

  constant C_AXILITE_BFM_CONFIG : t_axilite_bfm_config := (
    max_wait_cycles => 5,
    max_wait_cycles_severity => TB_WARNING,
    clock_period => clk_period,
    setup_time => clk_period/4,
    hold_time => clk_period/4,
    clock_period_margin => - 1 ns,
    clock_margin_severity => TB_WARNING,
    expected_response => OKAY,
    expected_response_severity => TB_FAILURE,
    bfm_sync => SYNC_ON_CLOCK_ONLY,
    protection_setting => UNPRIVILEGED_NONSECURE_DATA,
    match_strictness => MATCH_EXACT,
    num_aw_pipe_stages => 1,
    num_w_pipe_stages => 1,
    num_ar_pipe_stages => 1,
    num_r_pipe_stages => 1,
    num_b_pipe_stages => 1,
    id_for_bfm => ID_BFM,
    id_for_bfm_wait => ID_BFM_WAIT,
    id_for_bfm_poll => ID_BFM_POLL
  );

  signal axilite_if : ST_AXILite_32 := init_axilite_if_signals(AXI_ADDR_WIDTH, 32);
  signal alert_level : t_alert_level := error;

begin

  ----------------------------------------------------------------------------
  -- Clock generation
  --
  axi_aclk <= not axi_aclk after clk_period;

  ----------------------------------------------------------------------------
  -- Test process
  --
  test : process is

    -- Reset the AXI interface
    procedure axi_reset is
    begin
      axi_aresetn <= '0';
      wait for 100 ns;
      wait until rising_edge(axi_aclk);
      axi_aresetn <= '1';
      waitclk(axi_aclk, 10);
    end procedure;

    -- Write a data word to the AXI4-Lite interface
    procedure bus_write(addr : in unsigned; value : in std_logic_vector; err : out boolean) is
      variable awready_received : boolean;
      variable wready_received : boolean;
    begin
      -- Phase #1: write address & write data
      wait until rising_edge(axi_aclk);
      axi_awaddr <= std_logic_vector(addr);
      axi_awprot <= (others => '0'); -- don't care
      axi_awvalid <= '1';
      axi_wdata <= value;
      axi_wstrb <= (others => '1');
      axi_wvalid <= '1';
      awready_received := false;
      wready_received := false;
      loop
        wait until rising_edge(axi_aclk);
        if axi_awready = '1' then
          awready_received := true;
          axi_awaddr <= (others => 'X');
          axi_awprot <= (others => 'X');
          axi_awvalid <= '0';
        end if;
        if axi_wready = '1' then
          wready_received := true;
          axi_wdata <= (others => 'X');
          axi_wstrb <= (others => '0');
          axi_wvalid <= '0';
        end if;
        exit when awready_received and wready_received;
      end loop;
      -- Phase #2: write response
      wait until rising_edge(axi_aclk);
      axi_bready <= '1';
      loop
        wait until rising_edge(axi_aclk);
        exit when axi_bvalid = '1';
      end loop;
      if axi_bresp = AXI_OKAY then
        err := false;
      else
        err := true;
      end if;
      axi_bready <= '0';
    end procedure;

    -- Read a data word from the AXI4-Lite interface
    procedure bus_read(addr : in unsigned; value : out std_logic_vector; err : out boolean) is
    begin
      -- Phase #1: read address
      axi_araddr <= std_logic_vector(addr);
      axi_arprot <= (others => '0'); -- don't care
      axi_arvalid <= '1';
      loop
        wait until rising_edge(axi_aclk);
        exit when axi_arready = '1';
      end loop;
      axi_araddr <= (others => 'X');
      axi_arprot <= (others => 'X');
      axi_arvalid <= '0';
      -- Phase #2: read data
      wait until rising_edge(axi_aclk);
      axi_rready <= '1';
      loop
        wait until rising_edge(axi_aclk);
        exit when axi_rvalid = '1';
      end loop;
      axi_rready <= '0';
      value := axi_rdata;
      if axi_rresp = AXI_OKAY then
        err := false;
      else
        err := true;
      end if;
    end procedure;

    procedure axilite_write(
      constant addr_value : in unsigned;
      constant data_value : in std_logic_vector;
      constant msg : in string) is
    begin
      axilite_write(addr_value, -- keep as is
      data_value, -- keep as is
      msg, -- keep as is
      axi_aclk, -- Clock signal
      axilite_if, -- Signal must be visible in local process scope
      bitvis_vip_axilite.axilite_bfm_pkg.C_SCOPE, -- Just use the default
      shared_msg_id_panel, -- Use global, shared msg_id_panel
      C_AXILITE_BFM_CONFIG); -- Use locally defined configuration or C_AXILITE_BFM_CONFIG_DEFAULT
    end;

    procedure axilite_read(
      constant addr_value : in unsigned;
      variable data_value : out std_logic_vector;
      constant msg : in string) is
    begin
      axilite_read (addr_value, -- keep as is
      data_value, -- keep as is
      msg, -- keep as is
      axi_aclk, -- Clock signal
      axilite_if, -- Signal must be visible in local process scope
      bitvis_vip_axilite.axilite_bfm_pkg.C_SCOPE, -- Just use the default
      shared_msg_id_panel, -- Use global, shared msg_id_panel
      C_AXILITE_BFM_CONFIG, -- Use locally defined configuration or C_AXILITE_BFM_CONFIG_DEFAULT
      "");
    end;

    procedure axilite_check (
      constant addr_value : in unsigned;
      constant data_exp : in std_logic_vector;
      constant msg : in string) is
    begin
      axilite_check(addr_value, -- keep as is
      data_exp, -- keep as is
      msg, -- keep as is
      axi_aclk, -- Clock signal
      axilite_if, -- Signal must be visible in local process scope
      alert_level,
      bitvis_vip_axilite.axilite_bfm_pkg.C_SCOPE, -- Just use the default
      shared_msg_id_panel, -- Use global, shared msg_id_panel
      C_AXILITE_BFM_CONFIG); -- Use locally defined configuration or C_AXILITE_BFM_CONFIG_DEFAULT
    end;

    variable v_bus_error : boolean;
    variable v_num_errors : natural := 0;
    variable v_mem_reg : std_logic_vector(31 downto 0);
    variable v_addr : unsigned(AXI_ADDR_WIDTH - 1 downto 0);
    variable v_strobe_count_old : natural;

  begin
    -- Initialize the AXI bus
    -- ======================
    print("Initializing the AXI bus");
    axi_awaddr <= (others => 'X');
    axi_awvalid <= '0';
    axi_wdata <= (others => 'X');
    axi_wstrb <= (others => 'X');
    axi_wvalid <= '0';
    axi_araddr <= (others => 'X');
    axi_arvalid <= '0';
    axi_rready <= '0';
    axi_bready <= '0';

    -- Initialize DUT user input ports
    -- ===============================
    print("Initializing DUT input ports");

    -- Reset the DUT
    -- =============
    print("Resetting the DUT");
    axi_reset;

    -- Test the memory interfaces
    -- ==========================

    v_addr := AXI4LITE_TESTER_DEFAULT_BASEADDR+TEST1_OFFSET;
    v_mem_reg := X"AAAA5555";
    bus_write(v_addr, v_mem_reg, v_bus_error);
    if v_bus_error then
      v_num_errors := v_num_errors + 1;
    end if;

    bus_read(v_addr, v_mem_reg, v_bus_error);
    if v_bus_error or v_mem_reg /= X"AAAA5555" then
      v_num_errors := v_num_errors + 1;
    end if;

    v_addr := AXI4LITE_TESTER_DEFAULT_BASEADDR+TEST2_OFFSET;
    v_mem_reg := X"5555AAAA";
    bus_write(v_addr, v_mem_reg, v_bus_error);
    if v_bus_error then
      v_num_errors := v_num_errors + 1;
    end if;

    bus_read(v_addr, v_mem_reg, v_bus_error);
    if v_bus_error or v_mem_reg /= X"5555AAAA" then
      v_num_errors := v_num_errors + 1;
    end if;

    for i in 0 to TEST3_ARRAY_LENGTH - 1 loop
      -- Write a data word to the memory
      -- =================================
      v_addr := AXI4LITE_TESTER_DEFAULT_BASEADDR+8+i*4;
      v_mem_reg := std_logic_vector(to_unsigned(i, v_mem_reg'length));
      bus_write(v_addr, v_mem_reg, v_bus_error);
      if v_bus_error then
        v_num_errors := v_num_errors + 1;
      end if;
    end loop;

    -- Read the memory
    for i in 0 to TEST3_ARRAY_LENGTH - 1 loop
      bus_read(AXI4LITE_TESTER_DEFAULT_BASEADDR+8+i*4, v_mem_reg, v_bus_error);
    end loop;

    -- Test the reset values of all bus-writable register fields
    -- =========================================================

    -- Test the correct operation of every register field
    -- ==================================================

    -- Report test results
    if v_num_errors = 0 then
      print("*** Simulation PASS *** ");
    else
      print("*** Simulation FAIL (" & integer'image(v_num_errors) & " errors) ***");
    end if;

    std.env.stop;

  end process;

  ----------------------------------------------------------------------------
  -- Strobe pulse counters
  --
  strobe_pulse_counters : process (axi_aclk) is
  begin
    if rising_edge(axi_aclk) then
    end if;
  end process;

  ----------------------------------------------------------------------------
  -- Register writable fields' values on strobe
  --
  register_writable_fields : process (axi_aclk) is
  begin
    if rising_edge(axi_aclk) then
    end if;
  end process;

  ----------------------------------------------------------------------------
  -- Unit under test
  --
  uut : entity work.axi4lite_tester_regs
    generic map(
      AXI_ADDR_WIDTH => AXI_ADDR_WIDTH,
      BASEADDR => std_logic_vector(axi4lite_TESTER_DEFAULT_BASEADDR)
    )
    port map(
      -- Clock and Reset
      axi_aclk => axi_aclk,
      axi_aresetn => axi_aresetn,
      -- AXI Write Address Channel
      s_axi_awaddr => axi_awaddr,
      s_axi_awprot => axi_awprot,
      s_axi_awvalid => axi_awvalid,
      s_axi_awready => axi_awready,
      -- AXI Write Data Channel
      s_axi_wdata => axi_wdata,
      s_axi_wstrb => axi_wstrb,
      s_axi_wvalid => axi_wvalid,
      s_axi_wready => axi_wready,
      -- AXI Read Address Channel
      s_axi_araddr => axi_araddr,
      s_axi_arprot => axi_arprot,
      s_axi_arvalid => axi_arvalid,
      s_axi_arready => axi_arready,
      -- AXI Read Data Channel
      s_axi_rdata => axi_rdata,
      s_axi_rresp => axi_rresp,
      s_axi_rvalid => axi_rvalid,
      s_axi_rready => axi_rready,
      -- AXI Write Response Channel
      s_axi_bresp => axi_bresp,
      s_axi_bvalid => axi_bvalid,
      s_axi_bready => axi_bready,
      -- User Ports
      user2regs => user2regs,
      regs2user => regs2user
    );

end architecture test;