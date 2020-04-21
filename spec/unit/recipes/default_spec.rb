#
# Cookbook:: testing_cookbook
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'testing_cookbook::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  it 'Should install pip3' do
    expect(chef_run).to install_package 'python3-pip'
  end


  it "Should create a Downloads directory" do
    expect(chef_run).to create_directory '/home/ubuntu/Downloads'
  end


  it "Should download Java" do
    expect(chef_run).to install_package 'default-jdk'
    expect(chef_run).to install_package 'default-jre'
  end
end
